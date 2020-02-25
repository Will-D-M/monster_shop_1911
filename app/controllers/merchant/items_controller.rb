class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.merchant.items
  end

  def update
    item = Item.find(params[:id])
    swap_active? item if params[:status]
    redirect_to "/merchant/items"
  end

  private

    def swap_active? item
      item.toggle(:active?)
      if params[:status] == 'deactivate'
        flash[:notice] = "#{item.name} is no longer for sale."
      elsif params[:status] == 'activate'
        flash[:notice] = "#{item.name} is now available for sale."
      end
      item.save
    end
end
