json.array!(@vehicle_reservations) do |vehicle_reservation|
  json.extract! vehicle_reservation, :id
  json.url vehicle_reservation_url(vehicle_reservation, format: :json)
end
