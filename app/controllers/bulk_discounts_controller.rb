class BulkDiscountsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show 
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  
  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    discount = BulkDiscount.new(markdown: params[:markdown], quantity_threshold: params[:quantity_threshold], merchant_id: params[:merchant_id])
    
    if discount.valid?
      discount.save
      redirect_to merchant_bulk_discounts_path(params[:merchant_id]), notice: "Successfully Created Bulk Discount"
    else 
      redirect_to new_merchant_bulk_discount_path(params[:merchant_id])
      flash[:alert] = discount.errors.full_messages.join(", ") + ". Please Try Again"
    end 
  end
  
  def edit 

  end
  
  def update 

  end

  def destroy
    BulkDiscount.find_by(id: params[:id], merchant_id: params[:merchant_id]).destroy
    
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end
end