# ClinicAqui

Projeto final da formação CajuHub Dev Junior — Banco de Dados com PostgreSQL.

A ClinicAqui é uma clínica de atenção primária que hoje controla agendamentos em caderno físico e fichas de pacientes em pastas de papel. Este projeto digitaliza o controle de pacientes, consultas e prescrições, garantindo histórico rastreável, dados confiáveis e relatórios prontos para a recepção e os médicos.

## Equipe

| Nome              | Papel    |
| ----------------- | -------- |
| Rafael Nascimento | Tech Lead |
| Thaissa           | Dev Jr   |
| Giovanna          | Dev Jr   |
| Constantini       | Dev Jr   |
| Laysa             | Dev Jr   |
| Antonio           | Dev Jr   |
| Carlos            | Dev Jr   |

## Estrutura do repositório

| Arquivo           | Conteúdo                                                                 |
| ----------------- | ------------------------------------------------------------------------ |
| `schema.sql`      | `CREATE TABLE` de todas as tabelas, com constraints e relacionamentos.   |
| `seed.sql`        | Dados de teste realistas, atendendo aos volumes mínimos do briefing.     |
| `queries.sql`     | As 12 perguntas de negócio respondidas em SQL, comentadas.               |
| `views.sql`       | Views `agenda_do_dia` e `historico_resumido_paciente`.                   |
| `transaction.sql` | Cenário transacional do registro de consulta, com ROLLBACK forçado.      |

Ordem de execução para subir o banco do zero:

```
schema.sql  →  seed.sql  →  views.sql
```

`queries.sql` e `transaction.sql` podem ser executados depois, em qualquer ordem.

## Modelo de dados (diagrama ER textual)

```
convenios (1) ──────< (N) pacientes
status_vinculo (1) ──< (N) medicos
especialidades (1) ──< (N) medicos

medicos (1) ──< (N) agendamentos >── (1) pacientes
agendamentos (1) ──── (0..1) consultas
medicos (1) ──< (N) consultas >── (1) pacientes
consultas (1) ──< (N) prescricoes >── (1) medicamentos
```

### Tabelas

- **convenios** — planos aceitos pela clínica (nome, código de operadora, procedimentos cobertos).
- **status_vinculo** — domínio do vínculo do médico (`ATIVO`, `INATIVO`).
- **especialidades** — áreas de atuação médica.
- **pacientes** — dados pessoais, contato, convênio (opcional) e status (`ATIVO`/`INATIVO`).
- **medicos** — nome, CRM, especialidade, contato e status de vínculo.
- **agendamentos** — reserva de horário (médico, paciente, início, fim, status).
- **consultas** — atendimento realizado, vinculado a um agendamento (1:1).
- **medicamentos** — itens que podem ser prescritos (categoria `COMUM` ou `CONTROLADO`).
- **prescricoes** — receita gerada em uma consulta (medicamento, dosagem, frequência, duração).

## Decisões de modelagem

**Agendamento e consulta em tabelas separadas.** Um agendamento existe antes do atendimento e pode terminar em `CANCELADA` ou `FALTOU`, sem virar consulta. Já a consulta só nasce quando o paciente é atendido. Modelar as duas como uma tabela só obrigaria campos opcionais demais e misturaria dois ciclos de vida diferentes. A relação 1:1 é garantida pelo `UNIQUE` em `consultas.id_agendamento`.

**Status como `VARCHAR` com `CHECK` em vez de tabela de domínio.** Para conjuntos pequenos e estáveis (`ATIVO/INATIVO` em paciente, status do agendamento), `CHECK` constraint dá a mesma garantia de integridade com menos JOINs. Para `status_vinculo` do médico optamos por tabela própria como exemplo do padrão alternativo dentro do mesmo schema.

**Medicamento como tabela separada, não texto livre na prescrição.** Permite responder perguntas do negócio (medicamento mais prescrito, variedade por médico, prescrições de controlados) sem depender de string matching. Também evita duplicidades de grafia.

**Convênio opcional no paciente.** A clínica também atende particular, então `id_convenio` em `pacientes` é nulo permitido.

**Especialidade única por médico.** O briefing menciona que um médico "pode ter uma ou mais", mas o cenário operacional da clínica trabalha com uma especialidade principal por profissional. Modelamos `medicos.id_especialidade` como FK direta. Caso a clínica passe a registrar múltiplas, basta promover para uma tabela associativa `medico_especialidade` sem alterar o restante.

**Integridade referencial sem cascata em pacientes/médicos.** Tentar deletar um paciente ou médico com agendamentos/consultas associados é bloqueado pelo Postgres (`RESTRICT` implícito). Isso preserva o histórico — a baixa é feita via `status = 'INATIVO'`. Já em `prescricoes` usamos `ON DELETE CASCADE` em relação a `consultas`: se uma consulta for removida, suas prescrições somem junto, porque elas só existem em função dela.

**Índices.** Criamos índices compostos em `agendamentos(id_medico, inicio_em)` e `agendamentos(id_paciente, inicio_em)` porque praticamente toda query operacional filtra por médico ou paciente em uma janela de tempo. Também há índice em `consultas(data_consulta)` para os relatórios de período.

## Volumes do seed

O `seed.sql` popula o banco com volumes acima do mínimo exigido:

- 9 médicos (8 ativos, 1 inativo) em 6 especialidades
- 42 pacientes (37 ativos, 5 inativos) distribuídos em 4 convênios + particulares
- 16 medicamentos (12 comuns, 4 controlados)
- 65 agendamentos nos últimos 2 meses, com status variados (30 realizadas, 15 agendadas, 10 canceladas, 10 faltou)
- 30 consultas — uma para cada agendamento realizado
- 33 prescrições distribuídas em 22 consultas distintas

O arquivo começa com `TRUNCATE ... RESTART IDENTITY CASCADE`, então pode ser executado várias vezes sem conflito de IDs.

## Como executar

Em uma instância PostgreSQL nova:

```sql
\i schema.sql
\i seed.sql
\i views.sql
```

Depois é possível rodar as perguntas de negócio com `\i queries.sql` e o cenário transacional com `\i transaction.sql`.
