class BulkDiscountsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    @bd = merchant.bulk_discounts
  end
end
