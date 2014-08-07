json.reservations @reservations do |r|
  json.extract! r, :reason, :begin_time, :end_time, :status

  json.requester r.user.name
  json.requester_url url_for(r.user)
end

json.similar_places @similar_places do |p|
  json.extract! p, :full_name
end

json.place @place.name
json.capacity @place.capacity
json.responsibles @responsibles, :email, :name
json.objects @objects, :name
