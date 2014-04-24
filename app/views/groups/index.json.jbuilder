json.array!(@groups) do |group|
  json.extract! group, :id, :name, :creationDate
  json.url group_url(group, format: :json)
end
