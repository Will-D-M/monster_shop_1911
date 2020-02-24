class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.change_status
    if merchant.status == "disabled"
      merchant.items.each { |item| item.active_false }
      flash[:success] = "#{merchant.name} is now disabled."
    else
      merchant.items.each { |item| item.active_true }
      flash[:success] = "#{merchant.name} is now enabled."
    end
    redirect_to "/admin/merchants"
  end

end
