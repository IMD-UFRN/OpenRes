[![Stories in Ready](https://badge.waffle.io/IMD-UFRN/OpenRes.png?label=ready)](https://waffle.io/IMD-UFRN/OpenRes)  
OpenRes
=======


##Resumo

O sistema será responsável pelo gerenciamento de recursos (salas e equipamentos) bem como suas reservas a servidores e colaboradores do Instituto Metrópole Digital.

##Funcionalidades

O sistema apresentará as seguintes funcionalidades:

####Cadastro de Recursos

####Reserva de Sala

####Reserva de Sala por Período (ex: um semestre inteiro)

####Cadastro de Setores da Instituição

####Gerenciamento de Membros dos Setores

##Regras de Negócio

####Permissões
-O usuário básico do sistema poderá solicitar reservas.

-Um usuário aprovador de reservas pode possui as mesmas permissões de usuário básicos + a permissão para aprovar ou rejeitar reservas e de gerenciar usuários básicos.

-Um usuário alocador de recursos possui as mesmas permissões de usuário aprovador de reservas + a permissão para alocar recursos em seu setor e de gerenciar usuários aprovadores de reservas.

-Um usuário chefe de setor possui as mesmas permissões de um usuário alocador de recursos + a permissão de gerenciar usuários alocadores de recursos + a permissão de gerenciar novos chefes de setor de seu setor + a permissão de receber relatórios de uso dos recursos de seu departamento.

-Um usuário administrador terá todas as permissões de chefe de setor em todos os setores.

-Fora de seu setor, todo usuário possui permissão apenas de usuário básico.

Tais permissões implicam no acesso limitado a determinadas sessões do sistema. 

###Reservas
Uma reserva pode possuir os seguintes estados:
-Pendente: quando solicitada sem nenhuma outra reserva também pendente para o horário/recursos solicitados.
-Pendente, com chances de não ser atendida: quando solicitada mesmo havendo outra reserva pendente para o horário/recursos solicitados.
-Rejeitada: quando verificada como inválida por algum usuário aprovador de reservas ou com permissões superiores.
-Aprovada: quando validada por algum usuário aprovador de reservas ou com permissões superiores.

