json.array!(@places) do |place|
  json.extract! place, 
  json.url place_url(place, format: :json)
end
