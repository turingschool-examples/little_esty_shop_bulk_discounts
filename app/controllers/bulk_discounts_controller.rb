class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create!(name: params[:name], percentage: params[:percentage], quantity: params[:quantity], id: find_new_id, merchant_id: @merchant.id)

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.update(bulk_discount_params)
    redirect_to "/merchant/#{@merchant.id}/bulk_discounts/#{@bulk_discount.id}"
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def find_new_id
    BulkDiscount.last.id + 1
  end

  private
  def bulk_discount_params
    params.permit(:name, :percentage, :quantity, :merchant_id)
  end
end
