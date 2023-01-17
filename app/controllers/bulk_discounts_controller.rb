class BulkDiscountsController < ApplicationController
  before_action :find_bulk_discount_and_merchant, only: [:show, :edit, :update, :destroy]
  before_action :find_merchant, only: [:new, :create, :index]

  def index 
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show 
  end


  def edit 

  end

  def update 
    if @bulk_discount.update(bulk_discount_params) 
      redirect_to merchant_bulk_discounts_path(@merchant)
    else 
      redirect_to edit_merchant_bulk_discount_path(@merchant)
      flash[:alert] = "Error: #{error_message(@bulk_discount.errors)}"
    end
  end

  def new 

  end

  def create 
    bulk_discount = BulkDiscount.new(percentage: params[:percentage],
                                      threshold: params[:threshold], 
                                      merchant_id: params[:merchant_id])
    if bulk_discount.save 
      redirect_to merchant_bulk_discounts_path(@merchant)
    else 
      redirect_to new_merchant_bulk_discount_path(@merchant)
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end



  def destroy 
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

private 
  def find_bulk_discount_and_merchant 
    @bulk_discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def bulk_discount_params
    # binding.pry
    params.require(:bulk_discount).permit(:percentage, :threshold, :merchant_id)
  end
end