class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show 
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def create 
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.new(percentage: params[:percentage], threshold: params[:threshold], merchant_id: params[:merchant_id])

    if bulk_discount.save 
      redirect_to merchant_bulk_discounts_path(merchant)
    else 
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def destroy 
    merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end
end