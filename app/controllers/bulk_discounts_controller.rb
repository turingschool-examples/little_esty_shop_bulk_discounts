class BulkDiscountsController < ApplicationController 
  def index 
    if params[:merchant_id].present?
      @bulk_discounts = BulkDiscount.where(merchant_id: params[:merchant_id])
    else 
      @bulk_discounts = BulkDiscount.all
    end 
  end

  def show 
    
  end
end