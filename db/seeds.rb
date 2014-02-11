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

lab_info       = RoomType.create(name: "Laboratório de Informática" , description: "Laboratório para uso diverso.")
administrativo = RoomType.create(name: "Administrativo"             , description: "Sala atividades técnico administrativas do instituto.")
reuniao        = RoomType.create(name: "Sala de Reuniões"           , description: "Sala de reuniões e video-conferências.")
professores    = RoomType.create(name: "Sala de Professores"        , description: "Sala de docentes da instituição.")
auditorio      = RoomType.create(name: "Auditório"                  , description: "Auditório para eventos.")
sala_de_aula   = RoomType.create(name: "Sala de Aula"               , description: "Sala de aula sem computadores.")
lab_pesquisa   = RoomType.create(name: "Laboratório de Pesquisa"    , description: "Laboratório para pesquisa de grupos da instituição.")
empresa        = RoomType.create(name: "Empresa"                    , description: "Sala para empresa com sede na instituição.")
incubada       = RoomType.create(name: "Incubadação"                , description: "Sala para empresa incubada pela instituição.")

######################### PRIMEIRO PAVIMENTO #########################

Place.create(code: "A101" , name: "Laboratório de Informática 01"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A102" , name: "Laboratório de Informática 02"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A103" , name: "Laboratório de Informática 03"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A104" , name: "Laboratório de Informática 04"     , capacity: 40, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A105" , name: "Sala de Desenho"                   , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A106" , name: "Equipe Moodle"                     , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A107" , name: "Rack"                              , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A108" , name: "Mini-Estúdio"                      , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A109" , name: "Sala de Desenho"                   , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A110" , name: "Equipe Moodle"                     , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "A111" , name: "Rack"                              , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "B101" , name: "Sala de Reuniões"                  , capacity: 00, sector_ids: imd_ug.id, room_type_id: reuniao.id)
Place.create(code: "B102" , name: "Diretoria Geral"                   , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B103" , name: "Secretaria"                        , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B104" , name: "Direção CIVT"                      , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B105" , name: "Secretaria"                        , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B106" , name: "Gerência Administrativa"           , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B107" , name: "Projetos e Patrimônio"             , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B108" , name: "Gerência Financeira"               , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B109" , name: "Sala de Reuniões"                  , capacity: 00, sector_ids: imd_ug.id, room_type_id: reuniao.id)
Place.create(code: "B108" , name: "Gerência Executiva"                , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B111" , name: "Sala de Reuniões"                  , capacity: 00, sector_ids: imd_ug.id, room_type_id: reuniao.id)
Place.create(code: "B112" , name: "Secretaria"                        , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B113" , name: "Almoxarifado"                      , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B114" , name: "Diretor Executivo"                 , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B115" , name: "Setor Técnico"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B115a", name: "Diretor Técnico"                   , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B115b", name: "Sala de Manutenção"                , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B115c", name: "Almoxafirado"                      , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B116" , name: "Setor Administrativo e Financeiro" , capacity: 00, sector_ids: imd_ad.id, room_type_id: administrativo.id)
Place.create(code: "B117" , name: "Equipe Pedagógica"                 , capacity: 00, sector_ids: imd_ed.id, room_type_id: administrativo.id)
Place.create(code: "B118" , name: "Almoxafirado"                      , capacity: 00, sector_ids: imd_ug.id, room_type_id: administrativo.id)
Place.create(code: "B119" , name: "Datacenter"                        , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B120" , name: "Sala de Apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)

######################### SEGUNDO PAVIMENTO #########################

Place.create(code: "A201" , name: "Secretaria"                        , capacity: 00, sector_ids: tec_ti.id, room_type_id: administrativo.id)
Place.create(code: "A201a", name: "Coordenação"                       , capacity: 00, sector_ids: tec_ti.id, room_type_id: administrativo.id)
Place.create(code: "A202" , name: "Laborartório de Informática"       , capacity: 20, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A203" , name: "Sala de apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "A203a", name: "Sala de Racks"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "A203b", name: "Almoxafirado"                      , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "A204" , name: "Laborartório de Informática"       , capacity: 20, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A205" , name: "Laborartório de Informática"       , capacity: 20, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A206" , name: "Psicologia e Serviço Social"       , capacity: 00, sector_ids: psicol.id, room_type_id: administrativo.id)
Place.create(code: "A207" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A208" , name: "Psicologia e Serviço Social"       , capacity: 20, sector_ids: psicol.id, room_type_id: administrativo.id)
Place.create(code: "A209" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A210" , name: "Sala de Reuniões"                  , capacity: 20, sector_ids: psicol.id, room_type_id: reuniao.id)
Place.create(code: "A211" , name: "Professores Curso Técnico"         , capacity: 03, sector_ids: tec_ti.id, room_type_id: professores.id)
Place.create(code: "A212" , name: "Laborartório de Informática"       , capacity: 20, sector_ids: tec_ti.id, room_type_id: lab_info.id)
Place.create(code: "A213" , name: "Professores Curso Técnico"         , capacity: 06, sector_ids: tec_ti.id, room_type_id: professores.id)
Place.create(code: "A214" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A215" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A216" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A217" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A218" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A219" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A220" , name: "Professores Curso Técnico"         , capacity: 06, sector_ids: tec_ti.id, room_type_id: professores.id)
Place.create(code: "A221" , name: "Refeitório"                        , capacity: 12, sector_ids: imd_ug.id, room_type_id: administrativo.id)
Place.create(code: "A222" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A223" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A224" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A225" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A226" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "A227" , name: "Professores BTI"                   , capacity: 02, sector_ids: dep_ti.id, room_type_id: professores.id)
Place.create(code: "B201" , name: "Sala de Apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B201a", name: "Sala de Racks"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B202" , name: "Sala de Treinamento"               , capacity: 00, sector_ids: dep_es.id, room_type_id: lab_info.id)
Place.create(code: "B203" , name: "Sala de Aula"                      , capacity: 64, sector_ids: dep_es.id, room_type_id: lab_info.id)
Place.create(code: "B204" , name: "Sala de Aula"                      , capacity: 64, sector_ids: dep_es.id, room_type_id: lab_info.id)
Place.create(code: "B205" , name: "Auditório"                         , capacity:192, sector_ids: imd_ug.id, room_type_id: auditorio.id)
Place.create(code: "B205" , name: "Auditório"                         , capacity: 60, sector_ids: imd_ug.id, room_type_id: auditorio.id)

######################### TERCEIRO PAVIMENTO #########################

Place.create(code: "A301" , name: "Laboratório de Estudos 01"         , capacity: 30, sector_ids: dep_ti.id, room_type_id: lab_info.id)
Place.create(code: "A302" , name: "Sala de Apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "A302a", name: "Sala de Racks"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "A303" , name: "Laboratório de Estudos 02"         , capacity: 30, sector_ids: dep_ti.id, room_type_id: lab_info.id)
Place.create(code: "A304" , name: "Laboratório de Estudos 03"         , capacity: 35, sector_ids: dep_ti.id, room_type_id: lab_info.id)
Place.create(code: "A305" , name: "Laboratório de Informática 01"     , capacity: 40, sector_ids: dep_ti.id, room_type_id: lab_info.id)
Place.create(code: "A306" , name: "Sala de Aula"                      , capacity: 64, sector_ids: dep_ti.id, room_type_id: sala_de_aula.id)
Place.create(code: "A307" , name: "Laboratório de Informática 02"     , capacity: 40, sector_ids: dep_ti.id, room_type_id: lab_info.id)
Place.create(code: "A308" , name: "Laboratório de Informática 04"     , capacity: 40, sector_ids: dep_ti.id, room_type_id: lab_info.id)
Place.create(code: "A309" , name: "Laboratório de Informática 03"     , capacity: 40, sector_ids: dep_ti.id, room_type_id: lab_info.id)
Place.create(code: "B301" , name: "Sala de Apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B301a", name: "Sala de Racks"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B302" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B303" , name: "Professores Visitantes"            , capacity: 02, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B304" , name: "Professores Visitantes"            , capacity: 02, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B305" , name: "Professores ES"                    , capacity: 02, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B306" , name: "Professores ES"                    , capacity: 02, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B307" , name: "Secretaria"                        , capacity: 00, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B308" , name: "Coordenação BTI"                   , capacity: 00, sector_ids: dep_ti.id, room_type_id: administrativo.id)
Place.create(code: "B309" , name: "Coordenação ES"                    , capacity: 00, sector_ids: dep_es.id, room_type_id: administrativo.id)
Place.create(code: "B310" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B311" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B312" , name: "Professores ES"                    , capacity: 02, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B313" , name: "Professores ES"                    , capacity: 02, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B314" , name: "Coordenação Pós"                   , capacity: 00, sector_ids: dep_es.id, room_type_id: administrativo.id)
Place.create(code: "B315" , name: "Laboratório de Pesquisa"           , capacity: 00, sector_ids: dep_es.id, room_type_id: lab_pesquisa.id)
Place.create(code: "B316" , name: "Laboratório de Pesquisa"           , capacity: 00, sector_ids: dep_es.id, room_type_id: lab_pesquisa.id)
Place.create(code: "B317" , name: "Laboratório de Pesquisa"           , capacity: 00, sector_ids: dep_es.id, room_type_id: lab_pesquisa.id)
Place.create(code: "B318" , name: "Laboratório de Pesquisa"           , capacity: 00, sector_ids: dep_es.id, room_type_id: lab_pesquisa.id)
Place.create(code: "B319" , name: "Laboratório de Pesquisa"           , capacity: 00, sector_ids: dep_es.id, room_type_id: lab_pesquisa.id)
Place.create(code: "B320" , name: "Laboratório de Pesquisa"           , capacity: 00, sector_ids: dep_es.id, room_type_id: lab_pesquisa.id)
Place.create(code: "B321" , name: "Sala de Reuniões"                  , capacity: 80, sector_ids: dep_es.id, room_type_id: reuniao.id)
Place.create(code: "B322" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B323" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B324" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B325" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B326" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)
Place.create(code: "B327" , name: "Professores ES"                    , capacity: 01, sector_ids: dep_es.id, room_type_id: professores.id)

######################### QUARTO PAVIMENTO #########################

Place.create(code: "A401" , name: "Sala de Reuniões"                  , capacity: 00, sector_ids: dep_es.id, room_type_id: reuniao.id)
Place.create(code: "A402" , name: "Empresa"                           , capacity: 00, sector_ids: incuba.id, room_type_id: empresa.id)
Place.create(code: "A403" , name: "Sala de Apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "A403a", name: "Sala de Racks"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "A404" , name: "Empresa"                           , capacity: 00, sector_ids: incuba.id, room_type_id: empresa.id)
Place.create(code: "A405" , name: "Empresa"                           , capacity: 00, sector_ids: incuba.id, room_type_id: empresa.id)
Place.create(code: "A406" , name: "Empresa"                           , capacity: 00, sector_ids: incuba.id, room_type_id: empresa.id)
Place.create(code: "A407" , name: "Incubada 01"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A408" , name: "Coworking"                         , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A409" , name: "Incubada 02"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A410" , name: "Incubada 03"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A411" , name: "Coworking"                         , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A412" , name: "Incubada 04"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A413" , name: "Incubada 05"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A414" , name: "Coworking"                         , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "A415" , name: "Incubada 06"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B401" , name: "Sala de Apoio"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B401a", name: "Sala de Racks"                     , capacity: 00, sector_ids: data_c.id, room_type_id: administrativo.id)
Place.create(code: "B402" , name: "Secretaria"                        , capacity: 00, sector_ids: incuba.id, room_type_id: administrativo.id)
Place.create(code: "B402a", name: "Chefia"                            , capacity: 00, sector_ids: incuba.id, room_type_id: administrativo.id)
Place.create(code: "B403" , name: "Chefia 03"                         , capacity: 00, sector_ids: incuba.id, room_type_id: administrativo.id)
Place.create(code: "B404" , name: "Chefia 02"                         , capacity: 00, sector_ids: incuba.id, room_type_id: administrativo.id)
Place.create(code: "B405" , name: "Chefia 01"                         , capacity: 00, sector_ids: incuba.id, room_type_id: administrativo.id)
Place.create(code: "B406" , name: "Incubada 21"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B407" , name: "Incubada 22"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B408" , name: "Incubada 23"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B409" , name: "Incubada 24"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B410" , name: "Incubada 25"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B411" , name: "Incubada 26"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B412" , name: "Incubada 27"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B413" , name: "Sala de Reuniões"                  , capacity: 00, sector_ids: incuba.id, room_type_id: reuniao.id)
Place.create(code: "B414" , name: "Sala de Reuniões"                  , capacity: 00, sector_ids: incuba.id, room_type_id: reuniao.id)
Place.create(code: "B415" , name: "Sala de Reuniões"                  , capacity: 00, sector_ids: incuba.id, room_type_id: reuniao.id)
Place.create(code: "B416" , name: "Incubada 03"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B417" , name: "Incubada 02"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B418" , name: "Incubada 01"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B419" , name: "Empresa"                           , capacity: 00, sector_ids: incuba.id, room_type_id: empresa.id)
Place.create(code: "B420" , name: "Incubada 20"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B421" , name: "Incubada 19"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B422" , name: "Incubada 18"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B423" , name: "Incubada 17"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B425" , name: "Incubada 16"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B427" , name: "Incubada 15"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B429" , name: "Incubada 14"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B431" , name: "Incubada 13"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B433" , name: "Incubada 12"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B435" , name: "Incubada 11"                       , capacity: 00, sector_ids: incuba.id, room_type_id: incubada.id)
Place.create(code: "B436" , name: "Empresa"                           , capacity: 00, sector_ids: incuba.id, room_type_id: empresa.id)


User.create(role: "admin", email: "admin@example.com", password: "rootadmin", name: "Admin", cpf: "092.092.092-92", sector_id: 1)
User.create(role: "sector_admin", email: "sector_admin@example.com", password: "rootadmin", name: "Sector Admin", cpf: "093.092.092-93", sector_id: 1)
User.create(role: "secretary", email: "secretary@example.com", password: "rootadmin", name: "Secretary", cpf: "094.092.092-94", sector_id: 1)
User.create(role: "basic", email: "basic@example.com", password: "rootadmin", name: "Basic", cpf: "095.092.092-95", sector_id: 1)

User.create(role: "basic", email: "marcel@example.com", password: "rootadmin", name: "Marcel", cpf: "096.092.092-96", sector_id: 3)
User.create(role: "basic", email: "gleydson@example.com", password: "rootadmin", name: "Gleydson", cpf: "097.092.092-97", sector_id: 3)

UserPlace.create(code: "A11", user_id: 5)
UserPlace.create(code: "A12", user_id: 6)

Reservation.create(user_id: 6, reason: "Palestra.", date: Date.today + 1.day, begin_time: Time.now, end_time: Time.now + 3.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Palestra.", date: Date.today + 1.day, begin_time: Time.now, end_time: Time.now + 4.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: Date.today + 2.day, begin_time: Time.now, end_time: Time.now + 5.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: Date.today + 2.day, begin_time: Time.now, end_time: Time.now + 6.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: Date.today + 3.day, begin_time: Time.now, end_time: Time.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: Date.today + 3.day, begin_time: Time.now, end_time: Time.now + 1.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: Date.today + 4.day, begin_time: Time.now, end_time: Time.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: Date.today + 4.day, begin_time: Time.now, end_time: Time.now + 3.hour, place_id:1)
