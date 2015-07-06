c = @category
json.id c.id.to_s
json.name c.name
json.type c.type
json.type_name c.type_name
if c.parent
  json.parent do
    json.id c.parent.id.to_s
    json.name c.parent.name
    json.type c.parent.type
    json.type_name c.parent.type_name
  end
end
