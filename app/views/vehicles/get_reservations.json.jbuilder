json.reservations @reservations do |r|
  json.extract! r, :reason, :begin_time, :end_time, :responsible, :status, :date
  json.driver r.driver.name
end
