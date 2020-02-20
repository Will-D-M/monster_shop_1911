class SessionsController < ApplicationController
  def new
    if current_admin?
      flash[:notice] = 'You are already logged in!'
      redirect_to '/admin'
    elsif current_merchant?
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
      session[:user_id] = user.id
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

  def destroy
    session.delete(:user_id)
    session.delete(:cart)
    flash[:notice] = 'You have logged out'
    redirect_to "/"
  end

end
