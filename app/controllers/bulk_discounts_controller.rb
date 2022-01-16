class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bd = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create!(bulk_discount_params)
    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  def show
    @bd = BulkDiscount.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bd = BulkDiscount.find(params[:id])
  end

  def update
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update(bulk_discount_params)
    redirect_to "/merchant/#{params[:merchant_id]}/bulk_discounts/#{params[:id]}"
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to "/merchant/#{params[:merchant_id]}/bulk_discounts"
  end

private
  def bulk_discount_params
    params.permit(:discount, :threshold)
  end
end
