class BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:merchant_id])
    if Rails.env.test?
      # Mock data to avoid API throttling limits
      @holidays = ["Memorial Day", "Independence Day", "Labor Day"]
    else
      @holidays = HolidayService.get_holidays.take(3)
    end
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = params[:merchant_id]
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.create!(bulk_discount_params)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    merchant.bulk_discounts.destroy(bulk_discount)
    redirect_to merchant_bulk_discounts_path(merchant)
  end
  
  private

  def bulk_discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold)
  end
end
