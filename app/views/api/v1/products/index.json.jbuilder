json.message "success"
json.success true
if params[:medicine_name].present?
  json.medicine do
    json.id @medicine.id
    json.name @medicine.name
    json.description @medicine.description
    json.cost @medicine.cost

  end

  json.data do
    json.id @medicine.id
    json.name @medicine.name
    json.description @medicine.description
    json.cost @medicine.cost

  end
else
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
end