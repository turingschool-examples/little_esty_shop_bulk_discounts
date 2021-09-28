class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = NagerService.next_three_holidays
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.create(discount_params)
    if @discount.update(discount_params)
      redirect_to merchant_discounts_path(@merchant), flash: {notice: "Discount updated."}
    else
      redirect_to edit_merchant_discount_path(@merchant, @discount), flash: {notice: "Discount not updated."}
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.create(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(merchant), flash: {notice: "New discount created"}
    else
      redirect_to new_merchant_discount_path(merchant), flash: {notice: "Please try again."}
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy

    redirect_to merchant_discounts_path(merchant), flash: {notice: "Discount deleted."}
  end

  private
    def discount_params
      params.require(:discount).permit(:percentage, :threshold, :merchant_id)
    end
end
