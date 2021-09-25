class BulkDiscountsController < ApplicationController
  before_action :find_bulk_discount_and_merchant, only: [:show, :update]
  before_action :find_merchant, only: [:index]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
  
  end



  private
  def bulk_discount_params
    params.require(:bulk_discounts).permit(:percentage_discount, :quantity_threshold)
  end

  def find_bulk_discount_and_merchant
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
