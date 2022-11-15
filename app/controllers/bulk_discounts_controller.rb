class BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create!(discounts_params)
    redirect_to((merchant_bulk_discounts_path(@merchant.id)))
  end

  private

  def discounts_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end
