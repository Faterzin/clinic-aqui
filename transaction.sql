Begin;

update agendamentos 
set status = 'REALIZADA'
where id = 31;

with consulta_I as ( --Tive que fazer dessa forma, pois o id 31 não existe na tabela de prescrições, ent criei uma váriavel e retornei ela
    insert into consultas (id_agendamento, id_medico, id_paciente, data_consulta, status, observacoes)
values(31,1,31,'2025-05-07 14:30:00','REALIZADA', 'Dor no joelho' )
returning id
)
insert into prescricoes (id_consulta, id_medicamento, dosagem, frequencia, duracao_tratamento)
Select id, 6, '400mg', '2x ao dia', 7 from consulta_I;
Commit;

Begin; --Teste para fazer o rollback e ver se está funcionando.
update agendamentos 
set status = 'REALIZADA'
where id = 31;

rollback;

select status from agendamentos where id = 31;

