class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = params[:user] ? User.new(params[:user]) : User.new_guest
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render "new"
    end
  end  
end
