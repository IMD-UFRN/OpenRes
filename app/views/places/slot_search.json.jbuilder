json.places @places do |p|
  json.extract! p, :full_name, :id
end

json.date @date
json.begin_time @begin_time
json.end_time @end_time
