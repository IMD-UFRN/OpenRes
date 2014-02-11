# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Sector.create(name: "BTI", description: "Departamento de Bacharelado em Tecnologia da Informação")
Sector.create(name: "Técnico em TI", description: "Departamento de Técnico em Tecnologia da Informação")
Sector.create(name: "BES", description: "Departamento de Bacharelado em Engenharia de Software")
Sector.create(name: "IMD Administrativo", description: "Departamento do Instituto Metrópole Digital")
Sector.create(name: "IMD Datacenter e Suporte Técnico", description: "Departamento do Instituto Metrópole Digital")
Sector.create(name: "IMD Uso Geral", description: "Departamento sem vínculo com a instituição")
Sector.create(name: "Incubação", description: "Departamento das empresas incubadas ou âncoras")
Sector.create(name: "Departamento de Informática Educacional", description: "Departamento de cursos/aulas de Informática Educacional")
Sector.create(name: "Psicologia e Serviço Social", description: "Departamento de apoio a alunos e servidores")

User.create(role: "admin", email: "admin@example.com", password: "rootadmin", name: "Admin", cpf: "092.092.092-92", sector_id: 1)
User.create(role: "sector_admin", email: "sector_admin@example.com", password: "rootadmin", name: "Sector Admin", cpf: "093.092.092-93", sector_id: 1)
User.create(role: "secretary", email: "secretary@example.com", password: "rootadmin", name: "Secretary", cpf: "094.092.092-94", sector_id: 1)
User.create(role: "basic", email: "basic@example.com", password: "rootadmin", name: "Basic", cpf: "095.092.092-95", sector_id: 1)

User.create(role: "basic", email: "marcel@example.com", password: "rootadmin", name: "Marcel", cpf: "096.092.092-96", sector_id: 3)
User.create(role: "basic", email: "gleydson@example.com", password: "rootadmin", name: "Gleydson", cpf: "097.092.092-97", sector_id: 3)

RoomType.create(name: "Laboratório de Informática", description: "Laboratório para uso diverso.")
RoomType.create(name: "Sala de Aula", description: "Sala para aulas dos cursos que ocupam o prédio.")
RoomType.create(name: "Sala de Professores", description: "Ambiente para professores.")
RoomType.create(name: "Laboratório de Pesquisa", description: "Laboratório para a realização de pesquisas por docentes.")
RoomType.create(name: "Empresas", description: "Sala para empresas incubadas no prédio.")

Place.create(name: "A01", description: "Sala A01.", code: "101", capacity: 10, sector_ids: 1, room_type_id: 2)
Place.create(name: "A02", description: "Sala A02.", code: "102", capacity: 10, sector_ids: 1, room_type_id: 2)
Place.create(name: "B01", description: "Lab. B01.", code: "201", capacity: 10, sector_ids: 2, room_type_id: 1)
Place.create(name: "B02", description: "Lab. B02.", code: "202", capacity: 10, sector_ids: 2, room_type_id: 1)

UserPlace.create(code: "A11", user_id: 5)
UserPlace.create(code: "A12", user_id: 6)

Reservation.create(user_id: 5, reason: "Minicurso.", date: Date.today - 1.day, begin_time: Time.now, end_time: Time.now + 1.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Minicurso.", date: Date.today - 1.day, begin_time: Time.now, end_time: Time.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Palestra.", date: Date.today + 1.day, begin_time: Time.now, end_time: Time.now + 3.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Palestra.", date: Date.today + 1.day, begin_time: Time.now, end_time: Time.now + 4.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: Date.today + 2.day, begin_time: Time.now, end_time: Time.now + 5.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: Date.today + 2.day, begin_time: Time.now, end_time: Time.now + 6.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: Date.today + 3.day, begin_time: Time.now, end_time: Time.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: Date.today + 3.day, begin_time: Time.now, end_time: Time.now + 1.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: Date.today + 4.day, begin_time: Time.now, end_time: Time.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: Date.today + 4.day, begin_time: Time.now, end_time: Time.now + 3.hour, place_id:1)
