class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def create
    bulk_discount = BulkDiscount.new(bulk_discount_params)
    @merchant = Merchant.find(params[:merchant_id])
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant.id)
    else
      redirect_to merchant_bulk_discounts_path(@merchant.id)
    end
  end

  private

  def bulk_discount_params
    params.permit(:id, :merchant_id, :percentage_discount, :quantity_threshold)
  end
end