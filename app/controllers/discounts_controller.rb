class DiscountsController < ApplicationController 
  before_action :find_merchant, only: [:index, :new, :create, :destroy]
  def index
    @discounts = @merchant.discounts
  end

  def new
    
  end

  def create 
    discount = @merchant.discounts.new(permitted_params)

    if discount.save 
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to new_merchant_discount_path(@merchant)
      flash[:alert] = 'Please fill in all fields!'
    end
  end

  def destroy 
    discount = @merchant.discounts.find(permitted_params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private 

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def permitted_params
    params.permit(:threshold, :percentage, :merchant_id, :id)
  end
end