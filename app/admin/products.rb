ActiveAdmin.register Product do
  menu priority: 4
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :cost, :description, :category

  index do
    selectable_column
    column :id
    column :name
    column :cost
    column :description
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Admin User" do
      f.input :name
      f.input :category, :as => :select, multiple: true, :collection => ProductCategory.all.map { |u| [u.name, u.id] }, required: true
      f.input :cost
      f.input :description
    end
    f.actions
  end
  controller do

    def create
      product = Product.create!(name: params[:product][:name], cost: params[:product][:cost], description: params[:product][:description])
      if product.save
        category_ids = params[:product][:category]
        category_ids.each do |category_id|
          unless category_id.empty?
            product.product_sub_categories.create!(product_category_id: category_id)
          end
        end
        redirect_to :admin_products, notice: "Product created successfully."
      end
    end
  end
  #
  # or
  #
  # permit_params do
  # permitted = [:name, :cost, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
