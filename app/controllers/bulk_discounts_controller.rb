class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
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
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    if @bulk_discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
    else
      redirect_to edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
    end
  end

  private

  def bulk_discount_params
    params.permit(:discount_percent, :threshold)
  end
end