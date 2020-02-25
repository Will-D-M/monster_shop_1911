class Merchant::ItemsController < Merchant::BaseController

  def index
    @items = current_user.merchant.items
  end

  def new
    @merchant = current_user.merchant
  end

  def create
    @merchant = current_user.merchant
    @item = @merchant.items.create(item_params)
    if @item.save
      flash[:success] = "#{@item.name} has saved."
      redirect_to "/merchant/items"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    flash[:success] = "#{item.name} has been deleted."
    redirect_to '/merchant/items'
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
