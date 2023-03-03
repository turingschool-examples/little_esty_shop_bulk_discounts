class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.bulk_discounts.create(new_discount_attributes)
    if discount.save
    redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:error] = "Discount not created: Required information missing."
      render :new
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.destroy(params[:id])
    
    redirect_to "/merchant/#{merchant.id}/bulk_discounts"
  end

  private
  def new_discount_attributes
    params.permit(:percentage_discount, :quantity_threshold)
  end
end