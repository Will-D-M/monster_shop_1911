class Merchant::DashboardController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
  end
end
