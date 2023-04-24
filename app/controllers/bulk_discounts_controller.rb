class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :index, :show, :edit]
  before_action :find_bulk_discount, only: [:show, :destroy, :edit]

  def index
  end

  def show
  end

  def new
  end

  def edit
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
end
