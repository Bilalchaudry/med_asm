ActiveAdmin.register ProductSubCategory do
  menu priority: 6
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :product_category_id, :product_id

  form do |f|
    f.inputs "Product Sub Category" do
      f.input :product_category_id, :as => :select, :collection => ProductCategory.all.map { |u| [u.name, u.id] }, required: true
      f.input :product_id, :as => :select, multiple: true, :collection => Product.all.map { |u| [u.name, u.id] }, required: true
    end
    f.actions
  end
  controller do

    def create
      product_ids = params[:product_sub_category][:product_id]
      product_ids.each do |product_id|
          unless product_id.empty?
            ProductSubCategory.create!(product_category_id: params[:product_sub_category][:product_category_id], product_id: product_id)
          end
        end
        redirect_to :admin_product_sub_categories, notice: "Category of products is created successfully."
      end
    end
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_category_id, :product_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
