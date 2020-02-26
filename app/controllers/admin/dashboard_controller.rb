class Admin::DashboardController < Admin::BaseController

  def index
    @orders = Order.all
  end
  
end
