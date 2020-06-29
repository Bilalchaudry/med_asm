class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # GET /projects
  # GET /projects.json
  def index
    @products = Product.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @product = Product.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        ProductCategory.create(product_id: @product.id, category_id: params[:product][:category_id].to_i)
        format.html { redirect_to @product, notice: 'Product is successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        category_ids = params[:product][:category]
        category_ids.each do |category_id|
          unless category_id.empty?
            @product.product_categories.create!(category_id: category_id)
          end
        end
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # # DELETE /projects/1
  # # DELETE /projects/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Product is deleted.' }
    end
  end


  def import
    errors = Product.import_file(params[:file])
    if errors == nil
      flash[:notice] = 'File Imported Successfully'
    else
      flash[:notice] = errors
    end
    redirect_to products_path
  end

  def download_template
    send_file(
        "#{Rails.root}/public/documents/products.csv",
        filename: "products.csv",
        )
  end

  def get_product_price
    medicine_name = params[:medicine_name]
    medicine = Product.find_by_name medicine_name
    render json: {
        price: medicine.cost
    }
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :cost, :description, :quantity,
                                    :category)
  end
end
