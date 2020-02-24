class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.merchant.items
  end
end
