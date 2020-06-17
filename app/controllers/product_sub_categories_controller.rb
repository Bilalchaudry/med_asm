class ProductSubCategoriesController < ApplicationController
  before_action :set_product_sub_category, only: [:edit, :update, :destroy, :show]
  # load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @product_sub_categories = ProductSubCategory.all rescue nil
  end


  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @product_sub_category = ProductSubCategory.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    category_id = params[:product_sub_category][:category_id]
    product_ids = params[:product_sub_category][:product_id]
    product_ids.each do |product_id|
      unless product_id.empty?
        ProductSubCategory.create!(product_category_id: category_id, product_id: product_id)
      end
    end
    respond_to do |format|
      format.html { redirect_to product_sub_categories_path, notice: 'Sub category successfully assignedd.' }
      format.json { render :show, status: :created, location: @product_sub_category }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @product_sub_category.update(product_sub_category_params)
        format.html { redirect_to product_sub_categories_path, notice: 'Product sub category was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_sub_category }
      else
        format.html { render :edit }
        format.json { render json: @product_sub_category.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @product_sub_category.destroy
    respond_to do |format|
      format.html { redirect_to product_sub_categories_path, notice: 'Product sub category is deleted.' }
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_sub_category
    @product_sub_category = ProductSubCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_sub_category_params
    params.require(:product_sub_category).permit(:product_category_id, :product_id)
  end

end
