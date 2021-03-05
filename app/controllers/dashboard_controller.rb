class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @holidays = HolidayService.get_holidays
    # require "pry"; binding.pry
  end
end
