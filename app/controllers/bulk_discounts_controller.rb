class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.get_holiday
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new; end

  def create; end

  def update; end

  def delete; end

  private

  def bulk_params
    params.permit(:percent, :threshold)
  end
end
