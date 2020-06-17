class Api::V1::ProductsController < ApplicationController
  include ErrorMessage
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  def index
    if params[:medicine_name].present?
      @products = Product.where(name: params[:medicine_name]) rescue nil
      if @products.empty?
        bad_request_error('There is no medicine with that name .', 404)
      end
    else
      @products = Product.all
    end
  end

end
