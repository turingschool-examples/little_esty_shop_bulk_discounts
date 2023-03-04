class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new, :create]
  before_action :find_bulk_discount, only: [:destroy, :show]
  
  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show

  end

  def new
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)

    if @bulk_discount.save
      flash[:notice] = "New bulk discount added"
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    else
      flash[:notice] = "Invalid form: Unable to create Bulk Discount"
 
      render :new
    end
  end

  def destroy
    @bulk_discount.destroy

    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end
  
  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:quantity_threshold, :percentage_discount)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end