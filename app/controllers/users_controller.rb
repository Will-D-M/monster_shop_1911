class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/profile"
      flash[:notice] = "You are registered and now logged in."
    elsif @user.duplicate_email?(@user.email)
      flash[:notice] = "Email is already in use, please try another."
      render :new
    else
      flash[:notice] = "Please fill out all required fields."
      render :new
    end
  end

  def show
    if !current_user
      render file: "/public/404"
    else
      @user = current_user
    end
  end

  def edit
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      if params[:password]
        flash[:notice] = 'Your password has been updated'
      else
        flash[:notice] = 'Information has been updated'
      end
      redirect_to '/profile'
    else
      if params[:password]
        flash[:notice] = 'Passwords do not match'
        redirect_to '/password'
      else
        flash[:notice] = flash.now[:error] = user.errors.full_messages.to_sentence
        redirect_to '/profile/edit'
      end
    end
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end
end
