class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all
  end

  def show
    @discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.where('id = ?', @discount.merchant_id)
  end
end
