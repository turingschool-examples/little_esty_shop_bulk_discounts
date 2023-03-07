class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    @holiday_info = HolidayFacade.info
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @new_bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @new_bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else 
      flash[:error] = @new_bulk_discount.errors.full_messages.to_sentence
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    merchant.bulk_discounts.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.find(params[:id])

      if bulk_discount.update(bulk_discount_params)
        flash[:success] = "Discount Successfully Updated"
        redirect_to merchant_bulk_discount_path(merchant.id, bulk_discount.id)
      else
        flash[:error] = error_message(bulk_discount.errors)
        redirect_to edit_merchant_bulk_discount_path(merchant.id, bulk_discount.id)
      end
    end

  private

  def bulk_discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold, :merchant_id, :id)
  end
end