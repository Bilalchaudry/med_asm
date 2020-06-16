ActiveAdmin.register User do
  menu priority: 3
  filter :id
  filter :user_name
  filter :email
  filter :phone
  filter :address
  index do
    selectable_column
    column :id
    column :user_name
    column :email
    column :phone
    column :address
    column :phone_verified
    actions
  end
  form do |f|
    f.inputs "Admin User" do
      f.input :email
      f.input :user_name
      f.input :phone
      f.input :address
      f.input :phone_verified
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :password,  :email, :user_name, :phone, :address, :latitude, :longitude, :phone_verified
  #
  # or
  #
  # permit_params do
  #   permitted = [:provider, :uid, :encrypted_password, :reset_password_token, :reset_password_sent_at, :allow_password_change, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :email, :user_name, :phone, :address, :latitude, :longitude, :role, :phone_verified, :status, :tokens]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
