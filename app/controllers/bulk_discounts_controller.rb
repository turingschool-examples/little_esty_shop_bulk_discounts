class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discounts = BulkDiscount.new 
    @discounts = @merchant.bulk_discounts.all
  end

end
