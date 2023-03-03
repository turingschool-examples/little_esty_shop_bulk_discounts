class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts  = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    # @bulk_discount = BulkDiscount.new
  end

  def create
    @bulk_discount = BulkDiscount.new(bulk_discount_params)
    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path
    else
      flash[:notice] = 'Invalid input'
      render :new
    end
  end


  private
  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end
end
