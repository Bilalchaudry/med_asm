json.message "success"
json.success true
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