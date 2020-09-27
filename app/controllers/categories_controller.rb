class CategoriesController < ApplicationController
  before_action :set_product_sub_category, only: [:edit, :update, :destroy, :show]
  # load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @categories = Category.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @category = Category.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html {redirect_to categories_path, notice: 'Category was successfully created.'}
        format.json {render :show, status: :created, location: @category}
      else
        format.html {render :new}
        format.json {render json: @category.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html {redirect_to categories_path, notice: 'Product sub category was successfully updated.'}
        format.json {render :show, status: :ok, location: @category}
      else
        format.html {render :edit}
        format.json {render json: @category.errors, status: :unprocessable_entity}
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      if @category.products.present?
      else
        @category.destroy!
        @destroy = true
      end
    rescue => e
      redirect_to categories_path, notice: e.message
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_sub_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :description)
  end

end
