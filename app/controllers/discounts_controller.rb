class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new, :create, :destory]

  def index
  end

  def new
  end

  def create
    @discount = @merchant.discounts.new(discount_create_params)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:error] = "Please use only whole numbers in Percent Discount and Quantity fields"
      render :new
    end
  end

  def destroy
    Discount.destroy(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    redirect_to merchant_discounts_path(@merchant)
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def discount_create_params
    params.permit(:percent_discount, :quantity)
  end
end
