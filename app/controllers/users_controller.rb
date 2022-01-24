# Users Controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username}!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:notice] = 'Account details updated successfully!'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
