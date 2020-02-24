class Merchant::ItemsController < ApplicationController
  def index
    @items = current_user.merchant.items
  end
end
