class BulkDiscountsController < ApplicationController
  before_action :find_merchant
  
  def index
    @discounts = @merchant.bulk_discounts
    @holidays = NagerFacade.new.holidays
  end

  def new
  end

  def create
    @discount = BulkDiscount.new(discount_params)
    if @discount.save
      redirect_to merchant_bulk_discounts_path
    else
      flash.notice = "Unable to Create - Missing Information"
      redirect_to new_merchant_bulk_discount_path
    end
  end

  def destroy
    @discount = @merchant.bulk_discounts.find(params[:id])
    @discount.destroy
    flash.notice = "Discount was Deleted!"
    redirect_to merchant_bulk_discounts_path
  end

  def show 
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def edit
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    @discount = @merchant.bulk_discounts.find(params[:id])
    @discount.update(discount_params)
    if @discount.save
      flash.notice = "Discount was Updated!"
      redirect_to merchant_bulk_discount_path(@merchant, @discount)
    else
      flash.notice = "Unable to Update - Missing Information"
      redirect_to edit_merchant_bulk_discount_path(@merchant, @discount)
    end
  end
  
  private 
  
  def find_merchant   
    @merchant = Merchant.find(params[:merchant_id])
  end

  def discount_params
    params.permit(:discount, :quantity, :merchant_id)
  end
end