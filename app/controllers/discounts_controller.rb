class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant_id = params[:merchant_id]
  end

  def create
    new_discount = BulkDiscount.create(
      percentage: params[:percentage],
      threshold: params[:threshold],
      merchant_id: params[:merchant_id]
    )
    new_discount.save
    redirect_to "/merchant/#{params[:merchant_id]}/discounts"
  end

  def destroy
    BulkDiscount.destroy(params[:discount_id])
    redirect_to "/merchant/#{params[:id]}/discounts"
  end
end
