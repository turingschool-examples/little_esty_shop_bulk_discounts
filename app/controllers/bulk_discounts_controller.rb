class BulkDiscountsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.country_holidays("US")
  end

  def show 
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  
  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    discount = BulkDiscount.new(bulk_discount_params)
    
    if discount.valid?
      discount.save
      redirect_to merchant_bulk_discounts_path(params[:merchant_id]), notice: "Successfully Created Bulk Discount"
    else 
      redirect_to new_merchant_bulk_discount_path(params[:merchant_id])
      flash[:alert] = discount.errors.full_messages.join(", ") + ". Please Try Again"
    end 
  end
  
  def edit 
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update 
    discount = BulkDiscount.find_by(id: params[:id], merchant_id: params[:merchant_id])
    discount.update(bulk_discount_params)
    
    if discount.valid?
      discount.save 
      redirect_to merchant_bulk_discount_path(discount.merchant_id, discount), notice: "Successfully Updated Bulk Discount #{discount.id}"
    else 
      respond_to do |format|
        format.html {redirect_to request.referrer}
      end
      flash[:alert] = discount.errors.full_messages.join(", ") + ". Please Try Again"
    end
  end

  def destroy
    BulkDiscount.find_by(bulk_discount_params).destroy
    
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private 

  def bulk_discount_params
    params.permit(:markdown, :quantity_threshold, :merchant_id)
  end
end