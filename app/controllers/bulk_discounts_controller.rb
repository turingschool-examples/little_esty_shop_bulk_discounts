class BulkDiscountsController < ApplicationController 
  before_action :holiday_information, only: [:index]

  def index
 
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.all
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id]) 

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.create!(bulk_discount_params)
    # @bulk_discount = @merchant.bulk_discounts.create!(bulk_discount_params)
    redirect_to merchant_bulk_discounts_path(@merchant.id) 
  end

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])

  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update(bulk_discount_params)
    
    redirect_to merchant_bulk_discount_path(merchant, bulk_discount)
  end

  def destroy 
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant.id)
  end

  def holiday_information 
    @holidays = HolidaySearch.new.holidays 
  end

  private

  def bulk_discount_params
    params.permit(:percentage, :quantity_threshold, :merchant_id)
  end

end