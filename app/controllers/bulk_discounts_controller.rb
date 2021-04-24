class BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:merchant_id])
    if Rails.env.test?
      # Mock data to avoid API throttling limits
      @holidays = ["Memorial Day", "Independence Day", "Labor Day"]
    else
      @holidays = HolidayService.get_holidays.take(3)
    end
  end

  def show
  end
end