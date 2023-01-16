class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    
  end

  def new
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = merchant.bulk_discounts.new
  end
  def create
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)
    if @bulk_discount.save
      flash[:notice] = 'New Bulk Discount was successfully created'
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:alert] = "New Bulk Discount Creation Failed!"
      render :new
    end
  end
end