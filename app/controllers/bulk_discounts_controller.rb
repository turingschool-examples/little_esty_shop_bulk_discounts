class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create!(percent_discount: params[:percent], quantity_threshold: params[:quantity], merchant_id: merchant.id)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    merchant = Merchant.find(params[:merchant_id])

    redirect_to merchant_bulk_discounts_path(merchant)
  end
end