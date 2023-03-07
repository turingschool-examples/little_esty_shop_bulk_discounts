class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts.all
    @holidays = HolidaysFacade.new.upcoming_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
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
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.update!(update_params)

    redirect_to merchant_bulk_discount_path(params[:merchant_id], @bulk_discount)
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create!(create_params)

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def destroy
    destroy_discount = BulkDiscount.find(params[:id])
    destroy_discount.destroy

    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private
  def update_params
    params.require(:bulk_discount).permit(:percentage, :threshold)
  end

  def create_params
    params.permit(:percentage, :threshold)
  end
end