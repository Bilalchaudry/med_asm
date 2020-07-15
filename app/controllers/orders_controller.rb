class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_prescription, only: :create

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @new_orders = @orders.where(status: 'Paid')
    @under_preparation_orders = @orders.where(status: 'Under_preparation')
    @completed_orders = @orders.where(status: 'Completed')
    @canceled_orders = @orders.where(status: 'Canceled')
    @all_orders = @new_orders + @under_preparation_orders + @completed_orders + @canceled_orders
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
    @order.user_id = @prescription.user_id
    @order.save!
    @prescription.update(status: "Proceed", recuring_status: params[:recuring_status].to_i)
    JSON.parse(params[:medicines]).each do |hash, key|
      @total_order_price = @total_order_price.to_i + hash['price'].to_i
      medicine_name = hash['medicine_name']
      medicine = Product.find_by_name(medicine_name)
      medicine.update(quantity: medicine.quantity - hash['medicine_quantity'].to_i)
      if medicine.present?
        order_product = OrderProduct.create!(order_id: @order.id, product_id: medicine.id, quantity: hash['medicine_quantity'],
                                             price: hash['price'], product_type: hash['type'],
                                             start_date: hash['start_date'], end_date: hash['end_date'],
        )
        if hash['day_time'].present?
          order_product.reminders.create!(timing: hash['day_time'].to_i, dose_quantity: hash['dose_quantity'],
                                          comment: hash['comment'], start_date: hash['start_date'], end_date: hash['end_date'],
                                          time: hash['day1_timepicker'], user_id: @prescription.user_id)
        end
        if hash['noon_time'].present?
          order_product.reminders.create!(timing: hash['noon_time'].to_i,
                                          dose_quantity: hash['noon_quantity'],
                                          comment: hash['noon_comment'], start_date: hash['start_date'], end_date: hash['end_date'], time: hash['noon_timepicker'], user_id: @prescription.user_id)
        end
        if hash['evening_time'].present?
          order_product.reminders.create!(comment: hash['evening_comment'], dose_quantity: hash['evening_quantity'], timing: hash['evening_time'].to_i, start_date: hash['start_date'], end_date: hash['end_date'],
                                          time: hash['evening_timepicker'], user_id: @prescription.user_id)

        end
      end
    end
    @order.update(total_amount: @total_order_price)

    respond_to do |format|
      if @order.save
        if params[:other_comment].present?
          @prescription.comments.create(message: params[:other_comment], role: 'Admin')
        end
        format.html { redirect_to prescriptions_path, notice: 'Invoice sent to customer successfully.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if params[:status] == 'Under Preparation'
      @order.update_attributes(status: 'Under_preparation')
    elsif params[:status] == 'Completed'
      @order.update_attributes(status: 'Completed')
    elsif params[:status] == 'cancel'
      @order.update_attributes(status: 'Canceled')
    elsif params[:status] == 'restore'
      @order.update_attributes(status: 'Paid')
    elsif params[:new_medicine] == 'true'
      medicine = Product.find_by_name(params[:medicine_name])
      @order.prescription.update(status: 'Proceed')
      order_product = @order.order_products.create!(order_id: @order.id, product_id: medicine.id, quantity: params[:medicine_quantity],
                                                    price: params[:price], product_type: params[:type],
                                                    start_date: params[:start_date], end_date: params[:end_date],
      )
      if params[:day_time].present?
        order_product.reminders.create!(timing: params[:day_time].to_i, dose_quantity: params[:dose_quantity],
                                        comment: params[:comment], start_date: params[:start_date], end_date: params[:end_date],
                                        time: params[:day1_timepicker], user_id: @order.user_id)
      end
      if params[:noon_time].present?
        order_product.reminders.create!(timing: params[:noon_time].to_i,
                                        dose_quantity: params[:noon_quantity],
                                        comment: params[:noon_comment], start_date: params[:start_date], end_date: params[:end_date], time: params[:noon_timepicker], user_id: @order.user_id)
      end
      if params[:evening_time].present?
        order_product.reminders.create!(comment: params[:evening_comment], dose_quantity: params[:evening_quantity], timing: params[:evening_time].to_i, start_date: params[:start_date], end_date: params[:end_date],
                                        time: hash['evening_timepicker'], user_id: @order.user_id)
      end
      if params[:other_comment].present?
        @order.prescription.comments.create(message: params[:other_comment], role: 'Admin')
      end
      if params[:get_med_id] == 'true'
        med_id = order_product.id
        render json: med_id
      end
    else
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to @order, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
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
