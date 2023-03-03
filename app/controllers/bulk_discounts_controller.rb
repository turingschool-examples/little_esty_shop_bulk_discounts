class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @new_bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @new_bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else 
      flash[:error] = @new_bulk_discount.errors.full_messages.to_sentence
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  private

  def bulk_discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold, :merchant_id)
  end
end