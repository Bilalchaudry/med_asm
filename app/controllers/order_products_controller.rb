class OrderProductsController < ApplicationController
  before_action :set_order_product, only: [:show, :edit, :update, :destroy]

  # GET /order_products
  # GET /order_products.json
  def index
    @order_products = OrderProduct.all
  end

  # GET /order_products/1
  # GET /order_products/1.json
  def show
  end

  # GET /order_products/new
  def new
    @order_product = OrderProduct.new
  end

  # GET /order_products/1/edit
  def edit
  end

  # POST /order_products
  # POST /order_products.json
  def create
    @order_product = OrderProduct.new(order_product_params)

    respond_to do |format|
      if @order_product.save
        format.html { redirect_to @order_product, notice: 'Order product was successfully created.' }
        format.json { render :show, status: :created, location: @order_product }
      else
        format.html { render :new }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_products/1
  # PATCH/PUT /order_products/1.json
  def update
    # Order.last.prescription.comments
    respond_to do |format|
      unless @order_product.quantity == params[:order_product][:quantity]
        medicine_price = @order_product.price / @order_product.quantity
        @order_product.price = medicine_price * params[:order_product][:quantity].to_i
        @order_product.product_type = params[:order_product][:type]
      end
      if @order_product.update(order_product_params)
        if params[:order_product][:morning_day_time].present?
          @order_product.reminders.first.update_attributes(timing: params[:order_product][:morning_day_time].to_i, dose_quantity: params[:order_product][:dose_quantity],
                                                           comment: params[:order_product][:comment],
                                                           start_date: params[:order_product][:start_date],
                                                           end_date: params[:order_product][:end_date],
                                                           time: params[:order_product][:morning_time])
        end
        if params[:order_product][:noon_day_time].present?
          if @order_product.reminders.second.present?
            @order_product.reminders.second.update_attributes(timing: params[:order_product][:noon_day_time].to_i, dose_quantity: params[:order_product][:noon_dose],
                                                              comment: params[:order_product][:noon_comment],
                                                              start_date: params[:order_product][:start_date],
                                                              end_date: params[:order_product][:end_date],
                                                              time: params[:order_product][:noon_time])
          else
            @order_product.reminders.create!(timing: params[:order_product][:noon_day_time].to_i, dose_quantity: params[:order_product][:noon_dose],
                                             comment: params[:order_product][:noon_comment],
                                             start_date: params[:order_product][:start_date],
                                             end_date: params[:order_product][:end_date],
                                             time: params[:order_product][:noon_time], user_id: @order_product.order.user_id)
          end
        end
        if params[:order_product][:evening_day_time].present?
          if @order_product.reminders.third.present?
            @order_product.reminders.third.update_attributes(timing: params[:order_product][:evening_day_time].to_i, dose_quantity: params[:order_product][:evening_dose],
                                                             comment: params[:order_product][:evening_comment],
                                                             start_date: params[:order_product][:start_date],
                                                             end_date: params[:order_product][:end_date],
                                                             time: params[:order_product][:evening_time])
          else
            @order_product.reminders.create!(timing: params[:order_product][:evening_day_time].to_i, dose_quantity: params[:order_product][:evening_dose],
                                             comment: params[:order_product][:evening_comment],
                                             start_date: params[:order_product][:start_date],
                                             end_date: params[:order_product][:end_date],
                                             time: params[:order_product][:evening_time], user_id: @order_product.order.user_id)
          end
        end
        if params[:order_product][:other_comment].present?
          @order_product.order.prescription.comments.create!(message: params[:order_product][:other_comment], role: 'Admin')
        end
        format.html { redirect_to prescriptions_path + "/?id=" + @order_product.order.prescription.id.to_s, notice: 'Order product was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_product }
      else
        format.html { render :edit }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_products/1
  # DELETE /order_products/1.json
  def destroy
    @order_product.destroy
    respond_to do |format|
      format.html { redirect_to order_products_url, notice: 'Order product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order_product
    @order_product = OrderProduct.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_product_params
    params.require(:order_product).permit(:quantity, :product_type,
                                          :start_date, :end_date, :product_id)
  end
end
