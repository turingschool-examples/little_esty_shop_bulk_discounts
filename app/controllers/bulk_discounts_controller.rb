class BulkDiscountsController < ApplicationController
  before_action :set_merchant
  before_action :set_bulk_items, only: [:show, :update]
  
  def index
    @bulk_discounts = @merchant.bulk_discounts
  #   require 'pry'; binding.pry
  end

  def show
    # @bulk_discount = BulkDiscount.find(params[:id])
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

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :discount, :quantity_threshold)
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_bulk_items
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end