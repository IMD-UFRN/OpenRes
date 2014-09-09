json.array!(@class_monitors) do |class_monitor|
  json.extract! class_monitor, :id
  json.url class_monitor_url(class_monitor, format: :json)
end
