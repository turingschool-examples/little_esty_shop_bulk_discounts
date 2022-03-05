class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @discount = BulkDiscount.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    bulk_discount = params[:bulk_discount]
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create(discount: bulk_discount[:discount], quantity: bulk_discount[:quantity], merchant: @merchant)
    redirect_to merchant_bulk_discounts_path
  end

  def destroy
    @merchant = Merchant.find_by(id: params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path
  end
end
