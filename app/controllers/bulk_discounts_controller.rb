class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])

    bulk_discount = BulkDiscount.create!(bulk_discount_params)
    redirect_to  merchant_bulk_discounts_path(@merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end
  
  def update 
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
    @discount.update(bulk_discount_params)
    redirect_to merchant_bulk_discount_path(@merchant, @discount)
  end 

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id]).destroy

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def bulk_discount_params
    params.permit(:percentage, :quantity_threshhold, :merchant_id)
  end
end