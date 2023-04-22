class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new, :create, :edit, :destroy]
  before_action :find_bulk_discount, only: [:show, :edit, :destroy]

  def index
    @bulk_discounts = @merchant.find_bulk_discounts
  end

  def show
    @merchant = @bulk_discount.bulk_discount_merchant
  end

  def new
  end

  def create
    @bulk_discount = BulkDiscount.new(bulk_discount_params)

    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash.alert = "Discount not created, please try again."

      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  def edit
  end

  def destroy
    @bulk_discount.destroy

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

private
  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end
end