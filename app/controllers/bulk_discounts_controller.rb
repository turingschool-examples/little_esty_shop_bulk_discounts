class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    
    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      render :new
    end
  end

  private

  def bulk_discount_params
    params.permit(:discount_percent, :quantity_threshold)
  end
end