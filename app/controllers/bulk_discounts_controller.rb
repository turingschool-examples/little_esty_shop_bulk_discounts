class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = NagerDateService.new.get_next_3_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.find(params[:id])

    if bulk_discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(merchant)
    else
      flash[:notice] = "#{error_message(bulk_discount.errors)}"
      redirect_to edit_merchant_bulk_discount_path(merchant, bulk_discount)
    end
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.create(bulk_discount_params)

    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:notice] = "#{error_message(bulk_discount.errors)}"
      redirect_to new_merchant_bulk_discount_path(merchant)
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])

    merchant.bulk_discounts.delete(bulk_discount)

    redirect_to merchant_bulk_discounts_path(merchant)
  end
end

private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :percentage_discount, :quantity_threshold)
  end
