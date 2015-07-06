json.total_pages @bills.total_pages
json.total_count @bills.total_count
json.current_page @bills.current_page
json.data do
  json.array! @bills do |b|
    json.id b.id.to_s
    json.type b.type
    json.type_name b.type_name
    json.amount b.amount
    json.title b.title
    json.description b.description
    json.date b.date
    if b.category
      json.category do
        json.id b.category.id.to_s
        json.name b.category.name
        json.type b.category.type
        json.type_name b.category.type_name
      end
    end
  end
end
