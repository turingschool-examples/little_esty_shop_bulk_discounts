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
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
    @new_bulk_discount = BulkDiscount.new(bulk_discount_params)

    if @new_bulk_discount.percentage_discount < 0
      @new_bulk_discount.errors.add(:percentage_discount, "cannot have a negative value")
      flash[:errors] = @new_bulk_discount.errors.full_messages.last
      redirect_to new_merchant_bulk_discount_path(@merchant.id)
    else
      @new_bulk_discount = @merchant.bulk_discounts.create(
        promo_name: bulk_discount_params[:promo_name], 
        percentage_discount: (bulk_discount_params[:percentage_discount].to_f / 100), 
        quantity_threshold: bulk_discount_params[:quantity_threshold]
      )
      if @new_bulk_discount.save
        redirect_to merchant_bulk_discounts_path(bulk_discount_params[:merchant_id])
        flash[:success] = "Your input has been saved."
      else
        redirect_to new_merchant_bulk_discount_path(@merchant.id)
        flash[:error] = "Please check your entries and try again."
      end
    end
  end

  private
      
  def bulk_discount_params
    params.permit(
      :promo_name,
      :percentage_discount,
      :quantity_threshold,
      :merchant_id
    )
  end
end
