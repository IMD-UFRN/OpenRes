json.array!(@user_places) do |user_place|
  json.extract! user_place, :id
  json.url user_place_url(user_place, format: :json)
end
