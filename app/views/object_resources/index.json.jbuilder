json.array!(@object_resources) do |object_resource|
  json.extract! object_resource, :id
  json.url object_resource_url(object_resource, format: :json)
end
