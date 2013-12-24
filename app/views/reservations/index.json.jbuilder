json.array!(@reservations) do |reservation|
  json.extract! reservation, 
  json.url reservation_url(reservation, format: :json)
end
