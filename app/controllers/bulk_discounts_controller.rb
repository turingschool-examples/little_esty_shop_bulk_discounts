class BulkDiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_bulk_discount, only: [:show, :destroy]


  def index
  end

  def new
  end

  def show
  end

  def create
    @bulk_discount = BulkDiscount.new(discount_params)
    if bulk_discount.save
      flash[:notice] = "New bulk discount has been created!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:notice] = "Unable to create bulk discount!"
      render new_merchant_bulk_discount(@merchant)
    end
  end

  def destroy
    if bulk_discount.delete
      flash[:notice] = "Bulk discount has been removed!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:notice] = "Unable to remove bulk discount!"
      render new_merchant_bulk_discount(@merchant)
    end
  end

private

  def discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold, :merchant_id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end
