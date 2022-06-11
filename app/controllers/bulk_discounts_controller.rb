class BulkDiscountsController < ApplicationController
before_action :find_merchant, only: [:index]
before_action :find_discount_and_merchant, only: [:show, :update]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
  end

  def show
  end

  def edit
  end

  def update
  end


  def create
  end

  def destroy
  end

  private

  def discount_params
    params.permit(:percent, :threshold, :merchant_id)
  end

  def find_discount_and_merchant
      @bulk_discount = BulkDiscount.find(params[:id])
      @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

end