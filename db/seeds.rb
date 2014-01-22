# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Sector.create(name: "BTI", description: "Departamento de Bacharelado em Tecnologia da Informação")
Sector.create(name: "BES", description: "Departamento de Bacharelado em Engenharia de Software")
Sector.create(name: "IMD", description: "Departamento do Instituto Metrópole Digital")

User.create(role: "admin", email: "admin@example.com", password: "rootadmin", name: "Admin", cpf: "092.092.092-92", sector_id: 1)
User.create(role: "sector_admin", email: "sector_admin@example.com", password: "rootadmin", name: "Sector Admin", cpf: "093.092.092-93", sector_id: 1)
User.create(role: "secretary", email: "secretary@example.com", password: "rootadmin", name: "Secretary", cpf: "094.092.092-94", sector_id: 1)
User.create(role: "basic", email: "basic@example.com", password: "rootadmin", name: "Basic", cpf: "095.092.092-95", sector_id: 1)

User.create(role: "basic", email: "marcel@example.com", password: "rootadmin", name: "Marcel", cpf: "096.092.092-96", sector_id: 3)
User.create(role: "basic", email: "gleydson@example.com", password: "rootadmin", name: "Gleydson", cpf: "097.092.092-97", sector_id: 3)

RoomType.create(name: "Laboratório", description: "Laboratório para uso diverso.")
RoomType.create(name: "Sala de Aula", description: "Sala para aulas dos cursos que ocupam o prédio.")

Place.create(name: "A01", description: "Sala A01.", code: "101", capacity: 10, sector_id: 1, room_type_id: 2)
Place.create(name: "A02", description: "Sala A02.", code: "102", capacity: 10, sector_id: 1, room_type_id: 2)
Place.create(name: "B01", description: "Lab. B01.", code: "201", capacity: 10, sector_id: 2, room_type_id: 1)
Place.create(name: "B02", description: "Lab. B02.", code: "202", capacity: 10, sector_id: 2, room_type_id: 1)

UserPlace.create(code: "A11", user_id: 5)
UserPlace.create(code: "A12", user_id: 6)

Reservation.create(user_id: 5, reason: "Minicurso.", date: DateTime.now, begin_time: DateTime.now, end_time: DateTime.now + 1.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Minicurso.", date: DateTime.now, begin_time: DateTime.now, end_time: DateTime.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Palestra.", date: DateTime.now + 1.day, begin_time: DateTime.now, end_time: DateTime.now + 3.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Palestra.", date: DateTime.now + 1.day, begin_time: DateTime.now, end_time: DateTime.now + 4.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: DateTime.now + 2.day, begin_time: DateTime.now, end_time: DateTime.now + 5.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: DateTime.now + 2.day, begin_time: DateTime.now, end_time: DateTime.now + 6.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: DateTime.now + 3.day, begin_time: DateTime.now, end_time: DateTime.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: DateTime.now + 3.day, begin_time: DateTime.now, end_time: DateTime.now + 1.hour, place_id:1)
Reservation.create(user_id: 5, reason: "Reunião.", date: DateTime.now + 4.day, begin_time: DateTime.now, end_time: DateTime.now + 2.hour, place_id:1)
Reservation.create(user_id: 6, reason: "Reunião.", date: DateTime.now + 4.day, begin_time: DateTime.now, end_time: DateTime.now + 3.hour, place_id:1)
