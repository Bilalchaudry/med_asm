class Api::V1::PrescriptionsController < ApiController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /prescriptions
  # GET /prescriptions.json
  def index
    @prescriptions = current_user.prescriptions
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

  def reminder
    @user_reminders = current_user.reminders
  end

  # POST /prescriptions
  # POST /prescriptions.json
  def create
    begin
      @prescription = current_user.prescriptions.new(prescription_params)
      @prescription.save!
      @prescription.comments.create(message: params[:prescription][:message], role: current_user.full_name) if params[:prescription][:message].present?
      render_success_response "Prescription sent to admin successfully"
    rescue => e
      bad_request_error(e.message)
    end
  end

  # PATCH/PUT /prescriptions/1
  # PATCH/PUT /prescriptions/1.json
  def update
    begin
      @prescription.update(status: "Pending")
      if params[:prescription][:recuring_status].present?
        @prescription.update(recuring_status: params[:prescription][:recuring_status])
      end
      @prescription.comments.create(message: params[:prescription][:message], role: current_user.full_name)
      render_success_response "Prescription sent to admin successfully"
    rescue => error
      bad_request_error(error.message)
    end
  end

  # DELETE /prescriptions/1
  # DELETE /prescriptions/1.json
  def destroy
    @prescription.destroy
    respond_to do |format|
      format.html { redirect_to prescriptions_url, notice: 'Prescription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prescription_params
    params.require(:prescription).permit(:status, :image, :recuring_status)
  end

end
