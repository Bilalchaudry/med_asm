json.message "success"
json.success true

json.data do

  json.id @resource.id
  json.full_name @resource.full_name
  json.phone @resource.phone
  json.email @resource.email
  json.gender @resource.gender
  json.age @resource.age
  json.blood_group @resource.blood_group
  json.image main_app.url_for(@resource.image)

end