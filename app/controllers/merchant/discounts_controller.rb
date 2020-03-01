class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = current_user.merchant.discounts
  end

  def new
  end

  def create
    @merchant = current_user.merchant
    @discount = @merchant.discounts.new(discount_params)
    if @discount.save
      flash[:success] = "#{@discount.name} has now been created."
      redirect_to "/merchant/discounts"
    else
      flash[:error] = @discount.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    if @discount.save
      flash[:success] = "Bulk Discount has been updated."
      redirect_to "/merchant/discounts"
    else
      flash[:error] = @discount.errors.full_messages.to_sentence
      render :edit
    end
  end



  private
    def discount_params
      params.permit(:name, :percent_off, :min_quantity)
    end
end
