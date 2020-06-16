json.message "success"
json.success true

json.data do

  json.id @resource.id
  json.full_name @resource.full_name
  json.phone @resource.phone
  json.email @resource.email
  json.gender @resource.gender

end