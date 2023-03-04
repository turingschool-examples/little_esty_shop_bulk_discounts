# frozen_string_literal: true

class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    if discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(params[:merchant_id], discount.id)
    else
      flash[:notice] = 'Invalid input.'
      redirect_to edit_merchant_bulk_discount_path(params[:merchant_id], discount.id)
    end
  end

  def create
    discount = BulkDiscount.new(bulk_discount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    else
      flash[:notice] = 'Invalid input.'
      redirect_to new_merchant_bulk_discount_path(params[:merchant_id])
    end
  end

  def destroy
    BulkDiscount.delete(params[:id])
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:percent_discounted, :quantity_threshold, :merchant_id)
  end
end
