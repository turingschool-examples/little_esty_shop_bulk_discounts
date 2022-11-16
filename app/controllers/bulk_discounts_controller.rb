class BulkDiscountsController < ApplicationController
  before_action :h_info,   only: [:index]

  def index
    @bulk_discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create!(discounts_params)
    redirect_to((merchant_bulk_discounts_path(@merchant.id)))
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.update(discounts_params)
    redirect_to(merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    redirect_to((merchant_bulk_discounts_path(@merchant.id)))
  end

  def h_info
    @holidays = HolidaySearch.new.holiday_info[0..2]
  end

  private

  def discounts_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end
