class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.create(new_discount_attributes)
    @discount.save
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def new_discount_attributes
    params.permit(:percentage_discount, :quantity_threshold)
  end
end