class DiscountsController < ApplicationController
  before_action :holidays

  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def holidays
    @holidays = HolidayService.get_dates
  end
end

