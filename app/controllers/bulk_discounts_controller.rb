class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
  end
  
  def show
    
  end
  
  def new
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
  end

  def create
    @new_bulk_discount = BulkDiscount.create(bulk_discount_params)

    if @new_bulk_discount.valid? && @new_bulk_discount.save
      redirect_to merchant_bulk_discounts_path(bulk_discount_params[:merchant_id])
      flash[:success] = "Your input has been saved."
    else
      redirect_to new_merchant_bulk_discount_path(bulk_discount_params[:merchant_id])
      flash[:error] = "Please check your entries and try again."
    end
  end

  private
      
  def bulk_discount_params
    params.permit(
      :promo_name,
      :discount_percentage,
      :quantity_threshold,
      :merchant_id,
    )
  end
end
