class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :create, :index]

  def index 
    @bulk_discounts = @merchant.bulk_discounts
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:discount, :threshold)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end