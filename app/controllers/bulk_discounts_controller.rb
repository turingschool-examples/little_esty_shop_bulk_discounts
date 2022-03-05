class BulkDiscountsController < ApplicationController
  def index
    @merchant = find_merchant
    @holidays = HolidayFacade.get_holiday
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = find_merchant
  end

  def create
    @merchant = find_merchant
    @merchant.bulk_discounts.create!(bulk_params)
    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  def update; end

  def delete; end

  private

  def find_merchant
    Merchant.find(params[:merchant_id])
  end

  def bulk_params
    params.permit(:percentage, :threshold)
  end
end
