class Merchant::DiscountsController < Merchant::BaseController

  def index
    @items = current_user.merchant.items
  end
end
