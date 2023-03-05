class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
  end
  
  def show
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(bulk_discount_params[:id])
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
  
  def edit
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
    @edit_bulk_discount = @merchant.bulk_discounts.find(bulk_discount_params[:id])

  end

  def update
    merchant = Merchant.find(bulk_discount_params[:merchant_id])
    @bulk_discount = BulkDiscount.find(bulk_discount_params[:id])
    
    if @update_bulk_discount = @bulk_discount.update(promo_name: bulk_discount_params[:bulk_discount][:promo_name], percentage_discount: bulk_discount_params[:bulk_discount][:percentage_discount], quantity_threshold: bulk_discount_params[:bulk_discount][:quantity_threshold])
      redirect_to merchant_bulk_discount_path(bulk_discount_params[:merchant_id], bulk_discount_params[:id])
      flash[:success] = "Your input has been saved."
    else
      redirect_to edit_merchant_bulk_discount_path(bulk_discount_params[:merchant_id], bulk_discount_params[:id])
      flash[:error] = "Please check your entries and try again."
    end
  end


  def destroy
    merchant = Merchant.find(bulk_discount_params[:merchant_id])
    merchant.bulk_discounts.destroy(bulk_discount_params[:id])

    redirect_to merchant_bulk_discounts_path(bulk_discount_params[:merchant_id])
  end

  private
      
  def bulk_discount_params
    params.permit(
      :promo_name,
      :percentage_discount,
      :quantity_threshold,
      :id,
      :merchant_id,
      bulk_discount: [:promo_name, :percentage_discount, :quantity_threshold]
    )
  end
end
