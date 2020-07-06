module OrdersHelper

  def prescription_comments
    prescription = Prescription.find(params[:id])
    @prescription_comments = prescription.comments
  end

end
