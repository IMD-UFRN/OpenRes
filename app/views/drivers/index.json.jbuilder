json.array!(@drivers) do |driver|
  json.extract! driver, :id
  json.url driver_url(driver, format: :json)
end
