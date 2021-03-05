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
end
