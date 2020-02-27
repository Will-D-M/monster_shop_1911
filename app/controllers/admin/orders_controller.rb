class Admin::OrdersController < Admin::BaseController
  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:order_id])
    order.ship
    redirect_to "/admin"
  end
end
