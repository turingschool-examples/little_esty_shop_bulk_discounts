class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.find_discounts_by(params[:merchant_id])
    require 'pry'; binding.pry
  end
end
