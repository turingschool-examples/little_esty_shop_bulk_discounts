class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    
  end

  def new
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = merchant.bulk_discounts.new
  end
end