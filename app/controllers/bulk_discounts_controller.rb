class BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = BulkDiscount.all
  end

  def show
  end


  private
  
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end