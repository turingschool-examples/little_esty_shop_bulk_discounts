class DiscountsController < ApplicationController
  def index
    # require "pry"; binding.pry
    @merchants = Merchant.all
    @merchant = Merchant.find(params[:merchant_id])
    # @merchant = Merchant.find(params[:id])
    @holidays = HolidayService.get_holidays
  end

  def show
    # require "pry"; binding.pry
    # @merchant = Merchant.find(:id)
    @merchant = Merchant.find(:merchant_id)
  end

  def new
    @discount = Discount.new
  end

  def create
    # require "pry"; binding.pry
    Merchant.find(params[:merchant_id]).discounts.create!(discount_params)
    redirect_to merchant_discounts_path(params[:merchant_id])
  end

  private

  def discount_params
    params.permit(:percentage, :quantity)
  end
end
