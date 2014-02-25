json.reservations @reservations do |r|
  json.extract! r, :reason, :begin_time, :end_time, :status

  json.requester r.user.name
  json.requester_url url_for(r.user)
end

json.place @place.name
json.responsibles @responsibles, :email, :name