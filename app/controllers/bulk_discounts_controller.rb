class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    BulkDiscount.create!(percentage_discount: params[:bulk_discount][:percentage_discount],
                        quantity_threshold: params[:bulk_discount][:quantity],
                        merchant_id: params[:merchant_id]
                        )
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    @discount = merchant.bulk_discounts.find(params[:id]).destroy

    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private
  def bulk_discount_params
    params.permit(:percentage_discount,
                  :quantity_threshold,
                  :merchant_id)
  end

end