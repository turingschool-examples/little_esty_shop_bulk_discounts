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
    discount = @merchant.bulk_discounts.create(discount_attributes)
    if discount.save
    redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:error] = "Discount not created: Required information missing."
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk = BulkDiscount.find(params[:id])
    bulk.destroy!
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    if bulk_discount.update(discount_attributes)
      redirect_to merchant_bulk_discount_path(@merchant, bulk_discount)
    else
      flash[:error] = "Discount not updated: Required information missing."
      redirect_to edit_merchant_bulk_discount_path(@merchant, bulk_discount)
    end
  end

  private
  def discount_attributes
    params.permit(:percentage_discount, :quantity_threshold)
  end
end