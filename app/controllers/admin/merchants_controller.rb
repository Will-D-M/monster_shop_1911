class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.change_status
    if merchant.status == "disabled"
      flash[:success] = "#{merchant.name} is now disabled."
    else
      flash[:success] = "#{merchant.name} is now enabled."
    end
    redirect_to "/admin/merchants"
  end

end
