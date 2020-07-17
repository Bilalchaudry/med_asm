class Api::V1::SlotsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  def index
    @all_slots = current_user.slots

  end

  def create
    if params[:user][:first_day_time].present?
      current_user.slots.create!(day_time: params[:user][:first_day_time], slot_time: params[:user][:first_slot], slot_status: params[:morning])
    end
    if params[:user][:second_day_time].present?
      current_user.slots.create!(day_time: params[:user][:second_day_time], slot_time: params[:user][:second_slot], slot_status: params[:noon])
    end
    if params[:user][:third_day_time].present?
      current_user.slots.create!(day_time: params[:user][:third_day_time], slot_time: params[:user][:third_slot], slot_status: params[:eveing])
    end
    render_success_response "Slots selected successfully."
  end

  # def destroy
  #   if @slot.present?
  #     @slot.destroy
  #     render_success_response "Slots deleted successfully."
  #   else
  #     render_success_response "No slot found."
  #   end
  # end
  def delete_user_slot
    if current_user.slots.present?
      slot = current_user.slots.find_by(slot_time: params[:slot_time])
      slot.destroy!
      render_success_response "Slots deleted successfully."
    else
      render_success_response "No slot found."
    end
  end

  private

end