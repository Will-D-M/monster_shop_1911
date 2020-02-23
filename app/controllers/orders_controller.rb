class OrdersController <ApplicationController

  def index
  end

  def new
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.create(order_params)
    if @order.save
      cart.items.each do |item,quantity|
        @order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:success] = "Order has been created."
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
