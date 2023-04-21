class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new, :create]

  def index
    @bulk_discounts = @merchant.find_bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = @bulk_discount.bulk_discount_merchant
  end

  def new
  end

  def create
    require 'pry'; binding.pry
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end