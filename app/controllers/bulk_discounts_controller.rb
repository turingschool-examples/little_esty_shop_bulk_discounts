class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.new(bulk_discounts_params)
    # BulkDiscount.create!(quantity_threshold: params[:quantity_threshold],
    #                     percentage: params[:percentage],
    #                     merchant_id: params[:merchant_id])
    if bulk_discount.save(bulk_discounts_params)
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = 'Please fill in the missing fields.'
    end

  end
  
  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find_by(id: params[:id], merchant_id: params[:merchant_id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end
  
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update!(bulk_discounts_params)
    redirect_to merchant_bulk_discount_path(merchant.id, bulk_discount.id)
  end

  private
  
  def bulk_discounts_params
    params.permit(:quantity_threshold, :percentage)
  end
end