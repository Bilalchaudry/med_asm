class Api::V1::SlotsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  before_action :set_slot, only: [:destroy]

  def index
    @all_slots = current_user.slots

  end

  def create
    if params[:user][:first_day_time].present?
      current_user.slots.create!(day_time: params[:user][:first_day_time], slot_time: params[:user][:first_slot])
    end
    if params[:user][:second_day_time].present?
      current_user.slots.create!(day_time: params[:user][:second_day_time], slot_time: params[:user][:second_slot])
    end
    if params[:user][:third_day_time].present?
      current_user.slots.create!(day_time: params[:user][:third_day_time], slot_time: params[:user][:third_slot])
    end
    render_success_response "Slots selected successfully."
  end

  def destroy
    if @slot.present?
      @slot.destroy
      render_success_response "Slots deleted successfully."
    else
      render_success_response "No slot found."
    end
  end

  private

  def set_slot
    @slot = Slot.find(params[:id]) rescue nil
  end

end