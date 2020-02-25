class Admin::ItemsController < Admin::BaseController
  def index
    @items = Merchant.find(params[:id]).items
  end
end
