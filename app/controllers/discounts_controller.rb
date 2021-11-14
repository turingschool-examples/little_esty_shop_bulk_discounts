class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
    @holidays = HolidayFacade.create_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(merchant)
    else
      flash.notice = "All fields must be completed, get your act together."
      redirect_to new_merchant_discount_path(merchant)
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
      redirect_to merchant_discount_path(merchant, discount)
    else
      flash.notice = "All fields must be completed, get your act together."
      redirect_to edit_merchant_discount_path(merchant, discount)
    end
  end

    private
    def discount_params
      params.require(:discount).permit(:percentage_discount, :quantity_threshold)
    end
end
