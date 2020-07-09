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
        format.html {redirect_to @product, notice: 'Product is successfully created.'}
        format.json {render :show, status: :created, location: @product}
      else
        format.html {render :new}
        format.json {render json: @product.errors, status: :unprocessable_entity}
      end

    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.product_categories.last.update(category_id: params[:product][:category_id].to_i)

        format.html {redirect_to products_path, notice: 'Product was successfully updated.'}
        format.json {render :show, status: :ok, location: @product}
      else
        format.html {render :edit}
        format.json {render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  #
  # # DELETE /projects/1
  # # DELETE /projects/1.json
  def destroy
    begin
      if @product.orders.present?
      else
        @product.destroy!
        @destroy = true
      end
    rescue => e
      redirect_to products_path, notice: e.message
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
    if params[:medicine_name].present?
      medicine_name = params[:medicine_name]
      medicine = Product.find_by_name medicine_name
    else
      medicine_id = params[:medicine_id].to_i
      medicine = Product.find_by_id medicine_id
    end

    render json: {
        price: medicine.cost
    }
  end

  # def get_product_id
  #   if params[:medicine_name].present?
  #     prescription_product = Prescription.find(params[:prescription_id]).order.order_products.find_by_name params[:medicine_name]
  #   end
  #
  #   render json: {
  #       med_id: prescription_product.id
  #   }
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :cost, :description, :quantity,
                                    :category, :medicine_tag)
  end

end
