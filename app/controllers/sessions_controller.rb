# frozen_string_literal: true

# SessionsController
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:session][:username].downcase

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome, #{user.username}!"
    else
      flash.now[:alert] = 'Invalid credentials!'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'See you soon!'
  end
end
