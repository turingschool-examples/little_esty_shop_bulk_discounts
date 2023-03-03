class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts.all
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create!(create_params)

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def destroy
    destroy_discount = BulkDiscount.find(params[:id])
    destroy_discount.delete

    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private
  def create_params
    params.permit(:percentage, :threshold)
  end
end