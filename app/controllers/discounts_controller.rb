class DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.create!(discount_params)
    redirect_to merchant_discounts_path(@merchant.id)
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy 
    redirect_to merchant_discounts_path(@merchant.id)
  end

  private
  def discount_params
    params.permit(:name,:threshold,:percentage)
  end

end
