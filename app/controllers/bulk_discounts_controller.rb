class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new, :create, :destroy]
  
  def index
    @discounts = @merchant.bulk_discounts
    # @discounts = BulkDiscount.where(merchant_id: @merchant.id)
  end

  def create
    bulk = BulkDiscount.new(bulk_discount_params)
    if bulk.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else 
      flash.notice = "Try Again"
    end
  end

  def new
    @merchant
  end

  def destroy
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private 

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end

  def bulk_discount
    BulkDiscount.find(params[:id])
  end
end