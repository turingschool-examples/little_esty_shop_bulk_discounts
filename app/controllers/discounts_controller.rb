class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :create, :index]

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
    Discount.create!(percentage_discount: params[:percentage_discount].to_d,
                     quantity_threshold: params[:quantity_threshold],
                     merchant_id: params[:merchant_id])

    redirect_to merchant_discounts_path(@merchant)

  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
