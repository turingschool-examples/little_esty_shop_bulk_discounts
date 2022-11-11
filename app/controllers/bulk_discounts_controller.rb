class BulkDiscountsController < ApplicationController 

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.all 
  end
end