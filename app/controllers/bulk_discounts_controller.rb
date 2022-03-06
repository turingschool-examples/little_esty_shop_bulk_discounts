class BulkDiscountsController < ApplicationController
  def index
    @merchant = find_merchant
    @holidays = HolidayFacade.get_holiday
  end

  def show
    @merchant = find_merchant
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = find_merchant
  end

  def create
    merchant = find_merchant
    merchant.bulk_discounts.create!(percentage: params[:percentage], threshold: params[:threshold])
    redirect_to "/merchant/#{merchant.id}/bulk_discounts"
  end

  def edit
    @merchant = find_merchant
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    merchant = find_merchant
    bulk_discount = merchant.bulk_discounts.find(params[:id])
    bulk_discount.update(bulk_params)
    bulk_discount.save
    redirect_to "/merchant/#{merchant.id}/bulk_discounts/#{bulk_discount.id}"
  end

  def destroy
    merchant = find_merchant
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to "/merchant/#{merchant.id}/bulk_discounts"
  end

  private

  def find_merchant
    Merchant.find(params[:merchant_id])
  end

  def bulk_params
    params.require(:bulk_discount).permit(:percentage, :threshold)
  end
end
