json.message "success"
json.success true

json.data do

  json.id @resource.id
  json.full_name @resource.full_name
  json.gender @resource.gender
  json.phone @resource.phone
  json.email @resource.email

end
