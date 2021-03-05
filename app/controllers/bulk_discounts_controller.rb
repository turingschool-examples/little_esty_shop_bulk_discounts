class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.new(discount_params)
    if discount.save
      flash[:notice] = "New bulk discount has been created!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:notice] = "Unable to create bulk discount!"
      render new_merchant_bulk_discount(@merchant)
    end
  end

private

  def discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold, :merchant_id)
  end
end
