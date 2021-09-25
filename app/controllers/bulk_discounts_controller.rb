class BulkDiscountsController < ApplicationController
  before_action :find_bulk_discount_and_merchant, only: [:show, :update]
  before_action :find_merchant, only: [:index]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
  end

  def new
    @bulk_discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(bulk_discount_params)

    if discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
      flash[:alert] = "New bulk discount was created!"
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold)
  end

  def find_bulk_discount_and_merchant
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
