class BulkDiscountsController < ApplicationController
  def index
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end
end