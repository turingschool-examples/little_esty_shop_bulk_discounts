class BulkDiscountsController < ApplicationController
  before_action :set_merchant
  before_action :set_bulk_discount, only: [:show, :update, :destroy]
  
  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
  end

  def new
    @bulk_discount = BulkDiscount.new
  end

  def create
    @bulk_discount = BulkDiscount.new(bulk_discount_params)

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def update
    @bulk_discount.update(bulk_discount_params)

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def destroy
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :discount, :quantity_threshold)
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end