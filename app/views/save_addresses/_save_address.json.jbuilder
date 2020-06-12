json.extract! save_address, :id, :address, :latitude, :longitude, :default, :user_id, :created_at, :updated_at
json.url save_address_url(save_address, format: :json)
