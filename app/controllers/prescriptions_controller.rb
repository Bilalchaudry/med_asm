class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update]

  # GET /prescriptions
  # GET /prescriptions.json
  def index
    if params[:id].present?
      @prescription = Prescription.find_by_id(params[:id].to_i)
      if @prescription.present?
        @order = @prescription.order
        render 'prescriptions/detail'
      else
        @prescriptions = Prescription.all
        render :index
      end
    end
    @prescriptions = Prescription.all
    @new_prescriptions = @prescriptions.where(status: 'Pending')
    @sent_prescriptions = @prescriptions.where(status: 'Proceed').order(:id)
    @reject_prescriptions = @prescriptions.where(status: 'Reject').order(:id)
  end

  # GET /prescriptions/1
  # GET /prescriptions/1.json
  def show
  end

  # GET /prescriptions/new
  def new
    @prescription = Prescription.new
  end

  # GET /prescriptions/1/edit
  def edit
  end

  # POST /prescriptions
  # POST /prescriptions.json
  def create
    begin
      @prescription = current_user.prescriptions.new(prescription_params)
      @prescription.save!
      render_success_response "Prescription sent to admin successfully"
    rescue => e
      bad_request_error(e.message)
    end
  end

  # PATCH/PUT /prescriptions/1
  # PATCH/PUT /prescriptions/1.json
  def update
    if params[:status] == 'reject'
      @prescription.update(status: 'Reject')
    end
  end

  # DELETE /prescriptions/1
  # DELETE /prescriptions/1.json
  def destroy
    @order_product = OrderProduct.find_by_id(params[:id])
    prescription_id = @order_product.order.prescription.id
    @order_product.destroy
    respond_to do |format|
      format.html {redirect_to prescriptions_url + "?id=" + prescription_id.to_s, notice: 'Product deleted successfully.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prescription_params
    params.require(:prescription).permit(:status, :image)
  end

end
