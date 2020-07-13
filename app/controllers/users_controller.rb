class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  # load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
      @users = User.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
    if params[:history].present?
      @user = User.find(params[:id])
      @user_orders = @user.orders
      @user_prescriptions = @user.prescriptions.where.not(status: 'Proceed')
      render 'users/history'
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if params[:medicine].present?
      # puts params[:day_time]
      # puts params[:comment]
    else
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_update_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User is deleted.' }
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    users_params = params.require(:user).permit(:full_name, :phone, :email, :password_confirmation, :password)
    users_params[:gender] = params[:user][:gender].to_i
    return users_params
  end

  def user_update_params
    users_params = params.require(:user).permit(:full_name, :phone, :email, :gender)
    users_params[:gender] = params[:user][:gender].to_i
    return users_params
  end
end
