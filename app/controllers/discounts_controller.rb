class DiscountsController < ApplicationController
  before_action :holidays

  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.create(new_discount_params)
    if discount.save
      redirect_to merchant_discounts_path(params[:merchant_id])
    else 
      flash[:notice] = discount.errors.full_messages
      render :new
    end
    
  end
  
  def holidays
    @holidays = HolidayService.get_dates
  end

  private 
  def find_new_id 
    Discount.last.id + 1
  end

  def new_discount_params
    params.permit(:quantity, :percentage)
  end
end

