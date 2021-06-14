class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
    @holidays = HolidayService.public_holidays[0..2]
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    new_bd = @merchant.bulk_discounts.create!(bulk_discount_params)

    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])

    @merchant.bulk_discounts.find(params[:id]).destroy

    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])

    @discount.update!(bulk_discount_params)
    @discount.save

    redirect_to "/merchant/#{@merchant.id}/bulk_discounts/#{@discount.id}"

  end
  private
  def bulk_discount_params
    params.permit(:percent, :threshold)
  end
end
