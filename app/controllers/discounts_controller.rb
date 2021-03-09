class DiscountsController < ApplicationController
  before_action :holidays

  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end
  
  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.create(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(params[:merchant_id])
    else 
      flash[:notice] = discount.errors.full_messages
      render :new
    end
  end

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update 
    discount = Discount.find(params[:id])
    discount.update(discount_params)
    if discount.save
      redirect_to merchant_discount_path
    else 
      flash[:notice] = discount.errors.full_messages
      redirect_to edit_merchant_discount_path
    end
  end
  
  def holidays
    @holidays = HolidayService.get_dates
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.delete
    redirect_to merchant_discounts_path
  end

  private 
  def discount_params
    params.permit(:quantity, :percentage)
  end
end

