# Users Controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username}!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:notice] = 'Account details updated successfully!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if current_user == @user
    redirect_to root_path, notice: 'Account deleted! We are sad to see you go! :('
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    redirect_to @user, alert: 'Action not allowed' unless current_user == @user || current_user.admin?
  end
end
