class Api::V1::ProductsController < ApplicationController
  def index
    @products = Product.all 
  end
  def search_medicine
    if params[:medicine_name].present?
      @medicine = Product.find_by(name: params[:medicine_name]) rescue nil
      if @medicine.nil?
        bad_request_error('There is no medicine with that name .', 404)
      end
    else
      bad_request_error('Required parameters are missing .', 404)
    end
  end
end
