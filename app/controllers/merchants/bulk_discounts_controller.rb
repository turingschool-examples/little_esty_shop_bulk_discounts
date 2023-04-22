class Merchants::BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:error] = "Please fill in all fields, did you not read?"
      render :new
    end
  end

  def destroy
    # binding.pry
    discount = BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :discount_percent, :quantity_threshold)
  end
end