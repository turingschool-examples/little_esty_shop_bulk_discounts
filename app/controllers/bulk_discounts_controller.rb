class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = @bulk_discount.merchant
  end

  def new
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
