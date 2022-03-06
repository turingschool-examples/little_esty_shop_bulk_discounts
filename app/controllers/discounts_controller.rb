class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
    @holidays = HolidayService.new
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = Discount.new()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(discount_params)

    if discount.valid?
      merchant.discounts.push(discount)
      flash[:notice] = "#{discount.name} Has Been Created!"
      redirect_to merchant_discounts_path(merchant)
    else
      flash[:messages] = discount.errors.full_messages
      redirect_to new_merchant_discount_path(merchant)
    end
  end

  private

  def discount_params
    params.permit(:name, :percent_discount, :threshold, :merchant_id)
  end


end
