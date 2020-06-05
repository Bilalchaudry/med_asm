json.message "success"
json.success true

json.user do

  json.id @resource.id
  json.role @resource.role
  json.phone @resource.phone
  json.email @resource.email
  json.user_name @resource.user_name
  json.address @resource.address
  json.latitude @resource.latitude
  json.longitude @resource.longitude
  json.status @resource.status
  json.phone_verified @resource.phone_verified

end

json.data do

  json.id @resource.id
  json.role @resource.role
  json.phone @resource.phone
  json.email @resource.email
  json.user_name @resource.user_name
  json.address @resource.address
  json.latitude @resource.latitude
  json.longitude @resource.longitude
  json.status @resource.status
  json.phone_verified @resource.phone_verified

end
