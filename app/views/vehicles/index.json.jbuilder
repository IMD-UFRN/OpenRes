json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id
  json.url vehicle_url(vehicle, format: :json)
end
