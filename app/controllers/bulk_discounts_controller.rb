class BulkDiscountsController < ApplicationController
  before_action :find_bd_and_merchant, only: [:show, :edit, :update]
  before_action :find_merchant, only: [:new, :create, :index, :destroy]

  def index 
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
  end

  def new
  end

  def create
    BulkDiscount.create!(discount: params[:discount], 
                        threshold: params[:threshold], 
                        merchant: @merchant)
    redirect_to merchant_bulk_discounts_path(@merchant)
  end
  
  def destroy
    BulkDiscount.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(@merchant)
  end


  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:discount, :threshold)
  end

  def find_bd_and_merchant
    @bd = BulkDiscount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end