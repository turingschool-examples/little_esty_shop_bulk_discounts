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
    BulkDiscount.create!(bulk_discounts_params)
    # BulkDiscount.create!(quantity_threshold: params[:quantity_threshold],
    #                     percentage: params[:percentage],
    #                     merchant_id: params[:merchant_id])
    redirect_to merchant_bulk_discounts_path(merchant)
  end
  
  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find_by(id: params[:id], merchant_id: params[:merchant_id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  private
  
  def bulk_discounts_params
    params.permit(:quantity_threshold, :percentage, :merchant_id)
  end
end