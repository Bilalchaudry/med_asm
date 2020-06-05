json.message "success"
json.success true

json.user do

  json.id @resource.id
  json.role @resource.role
  json.phone @resource.phone
  json.email @resource.email
  json.user_name @resource.user_name
  json.language @resource.language_before_type_cast
  json.address @resource.address
  json.latitude @resource.latitude
  json.longitude @resource.longitude
  json.ride_type @resource.ride_type
  json.status @resource.status
  json.phone_verified @resource.phone_verified
  json.profile_image @resource.image.present? ? request.base_url + @resource.image.image.url : nil


end

json.data do

  json.id @resource.id
  json.role @resource.role
  json.phone @resource.phone
  json.email @resource.email
  json.user_name @resource.user_name
  json.language @resource.language_before_type_cast
  json.address @resource.address
  json.latitude @resource.latitude
  json.longitude @resource.longitude
  json.ride_type @resource.ride_type
  json.status @resource.status
  json.phone_verified @resource.phone_verified
  json.profile_image @resource.image.present? ? request.base_url + @resource.image.image.url : nil

end