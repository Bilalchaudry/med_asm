json.success true
json.message "success"

json.data do
  json.addresses @addresses.each do |address|
    json.id address.id
    json.address address.address
    json.latitude address.latitude
    json.longitude address.longitude.to_f
    json.default address.default

    json.additional_info_attributes do
      json.neighbour_hood address.additional_info.neighbour_hood rescue nil
      json.street_no address.additional_info.street_no rescue nil
      json.house_building_no address.additional_info.house_building_no rescue nil
      json.appartment_office_name address.additional_info.appartment_office_name rescue nil
      json.floor address.additional_info.floor rescue nil
      json.lane_pathway address.additional_info.lane_pathway rescue nil
      json.city address.additional_info.city rescue nil
      json.state address.additional_info.state rescue nil
    end
  end
end