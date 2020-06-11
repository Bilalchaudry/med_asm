class Api::V1::ProductsController < ApiController
  include ErrorMessage
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  def index
    if params[:medicine_name].present?
      @medicine = Product.find_by(name: params[:medicine_name]) rescue nil
      if @medicine.nil?
        bad_request_error('There is no medicine with that name .')
      end
    else
      @products = Product.all
    end
  end

  # def search_medicine
  #   if params[:medicine_name].present?
  #     @medicine = Product.find_by(name: params[:medicine_name]) rescue nil
  #     if @medicine.nil?
  #       bad_request_error('There is no medicine with that name .')
  #     end
  #   else
  #     bad_request_error('Required parameters are missing .')
  #   end
  # end
end
