class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index]
  before_action :find_bulk_discount, only: [:show, :destroy]

  def index
  end

  def show
  end

  def new
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end
