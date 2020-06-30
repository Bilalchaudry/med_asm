class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_prescription, only: :create

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.prescription_id = @prescription.id
    @order.save!
    @prescription.update(status: "Proceed")
    JSON.parse(params[:medicines]).each do |hash, key|
      @total_order_price = @total_order_price.to_i + hash['price'].to_i
      medicine_name = hash['medicine_name']
      medicine = Product.find_by_name(medicine_name)
      if medicine.present?
        OrderProduct.create!(order_id: @order.id, product_id: medicine.id, quantity: hash['medicine_quantity'],
                             price: hash['price'], timing: hash['day_time'], dose_quantity: hash['dose_quantity'],
                             comment: hash['comment'], start_date: hash['start_date'], end_date: hash['end_date'])
        @prescription.comments.create(message: params[:other_comment], role: 'admin')
      end
    end
    @order.update(total_amount: @total_order_price)

    respond_to do |format|
      if @order.save
        format.html {redirect_to prescriptions_path, notice: 'Invoice sent to customer successfully.'}
        format.json {render :show, status: :created, location: @order}
      else
        format.html {render :new}
        format.json {render json: @order.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html {redirect_to @order, notice: 'Order was successfully updated.'}
        format.json {render :show, status: :ok, location: @order}
      else
        format.html {render :edit}
        format.json {render json: @order.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html {redirect_to orders_url, notice: 'Order was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_prescription
    id = params[:url].split('?id=')[1].to_i
    @prescription = Prescription.find(id)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.fetch(:order, {})
  end
end
