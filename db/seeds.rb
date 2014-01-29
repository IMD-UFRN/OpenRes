# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


dep_ti = Sector.create(name: "BTI", description: "Departamento de Bacharelado em Tecnologia da Informação") 
tec_ti = Sector.create(name: "Técnico em TI", description: "Departamento de Técnico em Tecnologia da Informação")
dep_es = Sector.create(name: "BES", description: "Departamento de Bacharelado em Engenharia de Software")
imd_ad = Sector.create(name: "IMD Administrativo", description: "Departamento do Instituto Metrópole Digital")
data_c = Sector.create(name: "IMD Datacenter e Suporte Técnico", description: "Departamento do Instituto Metrópole Digital")
imd_ug = Sector.create(name: "IMD Uso Geral", description: "Departamento sem vínculo com a instituição")
incuba = Sector.create(name: "Incubação", description: "Departamento das empresas incubadas ou âncoras")
imd_ed = Sector.create(name: "Departamento de Informática Educacional" , description: "Departamento de cursos/aulas de Informática Educacional")
psicol = Sector.create(name: "Psicologia e Serviço Social"             , description: "Departamento de apoio a alunos e servidores")

lab_info       = RoomType.create(name: "Laboratório de Informática", description: "Laboratório para uso diverso.")
administrativo = RoomType.create(name: "Administrativo", description: "Sala atividades técnico administrativas do instituto.")
reuniao        = RoomType.create(name: "Sala de Reuniões", description: "Sala de reuniões e video-conferências.")

RoomType.create(name: "Sala de Aula", description: "Sala para aulas dos cursos que ocupam o prédio.")
RoomType.create(name: "Empresas", description: "Sala para empresas incubadas no prédio.")
RoomType.create(name: "Sala de Professores", description: "Ambiente para professores.")
RoomType.create(name: "Laboratório de Pesquisa", description: "Laboratório para a realização de pesquisas por docentes.")

######################### PRIMEIRO PAVIMENTO #########################


Place.create(code: "A101", name: "Laboratório de Informática 01"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A102", name: "Laboratório de Informática 02"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A103", name: "Laboratório de Informática 03"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A104", name: "Laboratório de Informática 04"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A105", name: "Sala de Desenho"                   , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A106", name: "Equipe Moodle"                     , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A107", name: "Rack"                              , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A108", name: "Mini-Estúdio"                      , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A109", name: "Sala de Desenho"                   , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A110", name: "Equipe Moodle"                     , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A111", name: "Rack"                              , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "B101", name: "Sala de Reuniões"                  , capacity: 00, sector_ids: imd_ug.id, room_type_id: reuniao.id)
Place.create(code: "B102", name: "Diretoria Geral"                   , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B103", name: "Secretaria"                        , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B104", name: "Direção CIVT"                      , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B105", name: "Secretaria"                        , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B106", name: "Gerência Administrativa"           , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B107", name: "Projetos e Patrimônio"             , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B108", name: "Gerência Financeira"               , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B109", name: "Sala de Reuniões"                  , capacity: 00, sector_ids: imd_ug.id, room_type_id: reuniao.id)
Place.create(code: "B108", name: "Gerência Executiva"                , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B111", name: "Sala de Reuniões"                  , capacity: 00, sector_ids: imd_ug.id, room_type_id: reuniao.id)
Place.create(code: "B112", name: "Secretaria"                        , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B113", name: "Almoxarifado"                      , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B114", name: "Diretor Executivo"                 , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B115", name: "Setor Técnico"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B115a", name: "Diretor Técnico"                  , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B115b", name: "Sala de Manutenção"               , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B115c", name: "Almoxafirado"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B116", name: "Setor Administrativo e Financeiro" , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B117", name: "Equipe Pedagógica"                 , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "B118", name: "Almoxafirado"                      , capacity: 00, sector_ids: imd_ug.id, room_type_id: administrativo.id)
Place.create(code: "B119", name: "Datacenter"                        , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B120", name: "Sala de Apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)







UserPlace.create(code: "A11", user_id: 5)
UserPlace.create(code: "A12", user_id: 6)

User.create(role: "admin", email: "admin@example.com", password: "rootadmin", name: "Admin", cpf: "092.092.092-92", sector_id: 1)
User.create(role: "sector_admin", email: "sector_admin@example.com", password: "rootadmin", name: "Sector Admin", cpf: "093.092.092-93", sector_id: 1)
User.create(role: "secretary", email: "secretary@example.com", password: "rootadmin", name: "Secretary", cpf: "094.092.092-94", sector_id: 1)
User.create(role: "basic", email: "basic@example.com", password: "rootadmin", name: "Basic", cpf: "095.092.092-95", sector_id: 1)

User.create(role: "basic", email: "marcel@example.com", password: "rootadmin", name: "Marcel", cpf: "096.092.092-96", sector_id: 3)
User.create(role: "basic", email: "gleydson@example.com", password: "rootadmin", name: "Gleydson", cpf: "097.092.092-97", sector_id: 3)

Reservation.create(user_id: 5, reason: "Minicurso.", date: DateTime.now - 1.day, begin_time: DateTime.now, end_time: DateTime.now + 1.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Minicurso.", date: DateTime.now - 1.day, begin_time: DateTime.now, end_time: DateTime.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Palestra.", date: DateTime.now + 1.day, begin_time: DateTime.now, end_time: DateTime.now + 3.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Palestra.", date: DateTime.now + 1.day, begin_time: DateTime.now, end_time: DateTime.now + 4.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: DateTime.now + 2.day, begin_time: DateTime.now, end_time: DateTime.now + 5.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: DateTime.now + 2.day, begin_time: DateTime.now, end_time: DateTime.now + 6.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: DateTime.now + 3.day, begin_time: DateTime.now, end_time: DateTime.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: DateTime.now + 3.day, begin_time: DateTime.now, end_time: DateTime.now + 1.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: DateTime.now + 4.day, begin_time: DateTime.now, end_time: DateTime.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: DateTime.now + 4.day, begin_time: DateTime.now, end_time: DateTime.now + 3.hour, place_id:1)
