class Admin::UsersController < Admin::BaseController

  def show
    @user = User.find(params[:user_id])
  end
end
