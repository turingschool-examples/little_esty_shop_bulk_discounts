class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :create, :index, :destroy]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
    @holidays = HolidayInfo.new('us')
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new

  end

  def create
    discount = Discount.new(percentage_discount: params[:percentage_discount].to_d,
                     quantity_threshold: params[:quantity_threshold],
                     merchant_id: params[:merchant_id])

    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to new_merchant_discount_path(@merchant)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant)
    # require 'pry'; binding.pry
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
