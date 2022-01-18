class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.create(discount_params)
    redirect_to merchant_discounts_path
  end

  # def create
  #   discount = Discount.create(discount_params)
  #   redirect_to merchant_discounts_path
  # end

private
  def discount_params
    params.permit(:name, :min_quantity, :percent_off)
  end
end
