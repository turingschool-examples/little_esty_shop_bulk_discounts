class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)

    if @bulk_discount.save
      flash[:notice] = "New bulk discount added"
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    else
      flash[:notice] = "Invalid form: Unable to create Bulk Discount"
      redirect_to new_merchant_bulk_discount_path(params[:merchant_id])
    end
  end
  
  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:quantity_threshold, :percentage_discount, :merchant_id)
  end
end