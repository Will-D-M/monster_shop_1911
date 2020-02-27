class Merchant::ItemOrdersController < Merchant::BaseController
  def update
    item_order = ItemOrder.find(params[:id])
    item_order.update(status: 1)
    item_order.save
    item_order.order.packaged
    item_order.order.save
    flash[:notice] = "#{item_order.item.name} has been fulfilled."
    redirect_to "/merchant/orders/#{item_order.order_id}"
  end
end
