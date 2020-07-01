class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!
  def update_status
    order = Order.find(params[:order][:id])
    @order = order.update_attributes!(status: params[:order][:status])
  end
end
