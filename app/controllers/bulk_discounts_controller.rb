class BulkDiscountsController < ApplicationController
  before_action :find_merchant, except: [:destroy]
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
  end

  def create
    @bulk_discount = BulkDiscount.new(bulk_discount_params)
    if @bulk_discount.save
    redirect_to_merchant_bulk_discounts_path(@merchant.id)
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
    params.permit(:quantity_threshold, :percentage_discount, :merchant_id, :bulk_discount)
  end
  
  def bulk_discount_params_update
    params.require(:bulk_discount).permit(:quantity_threshold, :percentage_discount, :merchant_id, :bulk_discount)
  end
end
