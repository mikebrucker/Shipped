class UsersController < ApplicationController
  # GET /users
  def index
    @users = user.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
  end

  # PATCH/PUT /users/1
  def update
  end

  # DELETE /users/1
  def destroy
    user = User.find(params[:id])
    if current_user == user
      flash[:success] = "#{user.email} Deleted"
      user.boats.schedules.destroy_all
      user.boats.destroy_all
      user.destroy
    else
      flash[:error] = "Unable to Delete User"
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
