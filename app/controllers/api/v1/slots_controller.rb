class Api::V1::SlotsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  def index
    @all_slots = current_user.slots
    @morning_slots = @all_slots.where(day_time: 'Morning');
    @noon_slots = @all_slots.where(day_time: 'Noon');
    @evening_slots = @all_slots.where(day_time: 'Evening');


  end

  def create
    if params[:user][:morning_first_slot].present?
      current_user.slots.create!(day_time: 'Morning', slot_time: params[:user][:morning_first_slot], slot_status: params[:morning_first_slot_status])
    end
    if params[:user][:morning_second_slot].present?
      current_user.slots.create!(day_time: 'Morning', slot_time: params[:user][:morning_second_slot], slot_status: params[:morning_second_slot_status])
    end
    if params[:user][:morning_third_slot].present?
      current_user.slots.create!(day_time: 'Morning', slot_time: params[:user][:morning_third_slot], slot_status: params[:morning_third_slot_status])
    end
    if params[:user][:morning_fourth_slot].present?
      current_user.slots.create!(day_time: 'Morning', slot_time: params[:user][:morning_fourth_slot], slot_status: params[:morning_fourth_slot_status])
    end
    if params[:user][:noon_first_slot].present?
      current_user.slots.create!(day_time: 'Noon', slot_time: params[:user][:noon_first_slot], slot_status: params[:noon_first_slot_status])
    end
    if params[:user][:noon_second_slot].present?
      current_user.slots.create!(day_time: 'Noon', slot_time: params[:user][:noon_second_slot], slot_status: params[:noon_third_slot_status])
    end
    if params[:user][:noon_third_slot].present?
      current_user.slots.create!(day_time: 'Noon', slot_time: params[:user][:noon_third_slot], slot_status: params[:noon_second_slot_status])
    end
    if params[:user][:noon_fourth_slot].present?
      current_user.slots.create!(day_time: 'Noon', slot_time: params[:user][:noon_fourth_slot], slot_status: params[:noon_fourth_slot_status])
    end

    if params[:user][:evening_first_slot].present?
      current_user.slots.create!(day_time: 'Evening', slot_time: params[:user][:evening_first_slot], slot_status: params[:evening_first_slot_status])
    end
    if params[:user][:evening_second_slot].present?
      current_user.slots.create!(day_time: 'Evening', slot_time: params[:user][:evening_second_slot], slot_status: params[:evening_second_slot_status])
    end
    if params[:user][:evening_third_slot].present?
      current_user.slots.create!(day_time: 'Evening', slot_time: params[:user][:evening_third_slot], slot_status: params[:evening_third_slot_status])
    end
    if params[:user][:evening_fourth_slot].present?
      current_user.slots.create!(day_time: 'Evening', slot_time: params[:user][:evening_fourth_slot], slot_status: params[:evening_fourth_slot_status])
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