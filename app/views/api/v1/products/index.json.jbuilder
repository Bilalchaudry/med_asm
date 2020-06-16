json.message "success"
json.success true
json.medicines @products.each do |product|
  json.id product.id
  json.name product.name
  json.description product.description
  json.cost product.cost

end

json.data @products.each do |product|
  json.id product.id
  json.name product.name
  json.description product.description
  json.cost product.cost

end