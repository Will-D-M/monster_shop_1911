class SessionsController < ApplicationController
  def new
    if current_user && current_user.admin?
      flash[:notice] = 'You are already logged in!'
      redirect_to '/admin'
    elsif current_user && current_user.merchant?
      flash[:notice] = 'You are already logged in!'
      redirect_to '/merchant'
    elsif current_user
      flash[:notice] = 'You are already logged in!'
      redirect_to "/profile"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user] = user.id
      flash[:notice] = "Login Successful"
      if user.admin?
        redirect_to '/admin'
      elsif user.merchant?
        redirect_to '/merchant'
      else
        redirect_to "/profile"
      end
    else
      flash[:notice] = "Invalid Email and/or Password"
      redirect_to "/login"
    end
  end

end
