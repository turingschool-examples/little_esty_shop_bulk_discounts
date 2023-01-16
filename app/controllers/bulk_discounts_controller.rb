# require 'bigdecimal'
class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = merchant.bulk_discounts.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)
    if @bulk_discount.save
      flash[:notice] = 'New Bulk Discount was successfully created'
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:alert] = "New Bulk Discount Creation Failed!"
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    if @bulk_discount.update(bulk_discount_params)
      flash[:notice] = 'Existing Bulk Discount was successfully updated!'
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
    else
      flash[:alert] = "Existing Bulk Discount Update Failed!"
      render :edit
    end
  end

  private
  
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold, :sanitized_percentage)
  end
end