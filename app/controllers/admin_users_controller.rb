class AdminUsersController < ApplicationController
  before_action :set_admin_user, only: [:edit, :update, :destroy, :show]
  # load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @admin_users = AdminUser.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @admin_user = AdminUser.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @admin_user = AdminUser.new(admin_user_params)

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to @admin_user, notice: 'Admin User was successfully created.' }
        format.json { render :show, status: :created, location: @admin_user }
      else
        format.html { render :new }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(admin_user_update_params)
        format.html { redirect_to admin_users_path, notice: 'Admin user was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'Admin is deleted.' }
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_user
    @admin_user = AdminUser.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_user_params
     params.require(:admin_user).permit(:username, :phone, :email, :password_confirmation, :password)
  end

  def admin_user_update_params
    params.require(:admin_user).permit(:username, :phone, :email, :password_confirmation, :password)

  end
end
