json.array!(@sectors) do |sector|
  json.extract! sector, 
  json.url sector_url(sector, format: :json)
end
