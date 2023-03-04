class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])

    new_params = bulk_discount_params
    new_params[:percentage_discount] = (new_params[:percentage_discount].to_f/100)

    new_bd = merchant.bulk_discounts.new(new_params)
   
    if new_bd.save
      flash[:success] = "Your new bulk discount was successfully created!"
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:notice] = new_bd.errors.full_messages.join(", ")
      redirect_to new_merchant_bulk_discount_path(merchant)
      # render :new
    end
  end

  private

  def bulk_discount_params
    params.permit(:title, :percentage_discount, :quantity_threshold)
  end
end