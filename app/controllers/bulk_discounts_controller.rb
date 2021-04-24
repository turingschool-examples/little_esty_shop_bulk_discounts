class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = NagerDateService.new.get_next_3_holidays
  end

  def show
  end

  def new
    @merchant = params[:merchant_id]
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.create(bulk_discount_params)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])

    merchant.bulk_discounts.delete(bulk_discount)

    redirect_to merchant_bulk_discounts_path(merchant)
  end
end

private
  def bulk_discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold)
  end
