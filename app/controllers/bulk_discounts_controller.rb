class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    merchant= Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:alert] = bulk_discount.errors.full_messages.to_sentence
      redirect_to new_merchant_bulk_discount_path(merchant)
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.delete
    redirect_to merchant_bulk_discounts_path()
  end


  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:discount, :threshold)
  end
end
