class Admin::OrdersController < Admin::BaseController

  def update
    order = Order.find(params[:order_id])
    order.ship
  end
end
