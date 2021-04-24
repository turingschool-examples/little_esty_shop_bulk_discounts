class BulkDiscountsController < ApplicationController

  def index
  @merchant = Merchant.find(params[:merchant_id])
  @holidays = NagerDateService.new.get_next_3_holidays
  end

  def show
  end
end
