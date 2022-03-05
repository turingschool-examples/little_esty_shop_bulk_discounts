class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def new
    @discount = BulkDiscount.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    bulk_discount = params[:bulk_discount]
    @merchant = Merchant.find(params[:merchant_id])
    #bd = BulkDiscount.create(bulk_discount[:discount], bulk_discount[:quantity])
    BulkDiscount.create(discount: bulk_discount[:discount], quantity: bulk_discount[:quantity], merchant: @merchant)
    redirect_to merchant_bulk_discounts_path
  end
end
