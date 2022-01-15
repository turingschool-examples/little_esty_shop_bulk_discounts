class DiscountsController < ApplicationController
  def index
    @merchant_discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show

  end
end
