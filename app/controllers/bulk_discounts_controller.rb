class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create!(name: params[:name], percentage: params[:percentage], quantity: params[:quantity], id: find_new_id, merchant_id: @merchant.id)

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def destroy
    binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def find_new_id
    BulkDiscount.last.id + 1
  end
end
