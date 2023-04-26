class BulkDiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_bulk_discount, only: [:show, :destroy, :edit, :update]

  def index
    @holidays = HolidaysBuilder.holiday_info
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    
    @bulk_discount.update(bulk_discount_params_update)
    redirect_to merchant_bulk_discount_path(@merchant.id, @bulk_discount.id)
  end

  def destroy
    #require 'pry'; binding.pry
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant.id)
  end

  def create
    @bulk_discount = BulkDiscount.new(bulk_discount_params)
    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant.id)
    else
      flash.notice = "Oopsie, there's a little hitch in your giddy up! Please try again."
      redirect_to new_merchant_bulk_discount_path(@merchant.id)
    end
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def bulk_discount_params
    params.permit(:quantity_threshold, :percent_discount, :merchant_id)
  end
  
  def bulk_discount_params_update
    params.require(:bulk_discount).permit(:quantity_threshold, :percent_discount, :merchant_id, :bulk_discount)
  end
end
