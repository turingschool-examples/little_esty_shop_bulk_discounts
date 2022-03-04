class BulkDiscountsController < ApplicationController
  before_action :find_merchant

  def index
    @discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
  end

  def create
    BulkDiscount.create(percent_discount: params[:percent_discount],
                        qty_threshold: params[:qty_threshold],
                        merchant: @merchant)
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def destroy
    discount = BulkDiscount.find(params[:id])
    discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end


  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percent_discount, :qty_threshold, :merchant_id)
  end
end
