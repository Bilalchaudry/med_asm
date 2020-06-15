class ProductCategoriesController < ApplicationController
  before_action :product_category, only: [:edit, :update, :destroy, :show]
  # load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @product_categories = ProductCategory.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @product_category = ProductCategory.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @product_category = ProductCategory.new(product_category_params)

    respond_to do |format|
      if @product_category.save
        format.html { redirect_to @product_category, notice: 'Product category was successfully created.' }
        format.json { render :show, status: :created, location: @product_category}
      else
        format.html { render :new }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to product_categories_path, notice: 'Product category was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @product_category.destroy
    respond_to do |format|
      format.html { redirect_to product_categories_path, notice: 'Product category is deleted.' }
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def product_category
    @product_category = ProductCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_category_params
    params.require(:product_category).permit(:name, :description)
  end

end
