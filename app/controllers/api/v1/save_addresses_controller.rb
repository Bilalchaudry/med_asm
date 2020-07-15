class Api::V1::SaveAddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @addresses = current_user.save_addresses.order(:default).reverse
    render json: {
        addresses: @addresses
    }
  end

  def create
    begin
      save_address = current_user.save_addresses.new save_address_params
      save_address.save!
      render_success_response "Address created successfully"

    rescue => e
      bad_request_error(e.message)
    end
  end

  def update
    begin
      save_address = SaveAddress.find_by_id(params[:id])
      if save_address.present?
        save_address.update!(save_address_params)
        if params[:save_address][:default] == true
          current_user.save_addresses.where.not(id: params[:id]).update(default: false)
        end
        render_success_response "Address updated successfully"
      else
        bad_request_error("Address not found with given id #{params[:id]}")
      end
    rescue => e
      bad_request_error(e.message)
    end
  end

  def destroy
    begin
      save_address = SaveAddress.find_by_id(params[:id].to_i)
      if save_address.present?
        save_address.destroy!
        render_success_response "Address deleted successfully"
      else
        bad_request_error("Address not found with given id #{params[:id]}")
      end
    rescue => e
      bad_request_error(e.message)
    end
  end

  private

  def save_address_params
    params.require(:save_address).permit(:address, :latitude, :longitude, :default)
  end

end
