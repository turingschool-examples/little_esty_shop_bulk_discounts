class BulkDiscountsController < ApplicationController

  def index
    @discounts = BulkDiscount.where(merchant_id: params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.next_three
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    
    if params[:holiday].present?
      @discount = BulkDiscount.new(name: params[:holiday][:name],
                                  percentage: params[:holiday][:percentage],
                                  quantity: params[:holiday][:quantity])
    else
      @discount = BulkDiscount.new
    end
  end

  def create
    bulk_discount = BulkDiscount.create(name: params[:bulk_discount][:name],
                                        quantity: params[:bulk_discount][:quantity],
                                        percentage: params[:bulk_discount][:percentage],
                                        merchant_id: params[:merchant_id])
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    else
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])      
    end
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
    @merchant = @discount.merchant
  end

  def update
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update(name: params[:bulk_discount][:name],
      quantity: params[:bulk_discount][:quantity],
      percentage: params[:bulk_discount][:percentage],
      merchant_id: params[:merchant_id])
    redirect_to merchant_bulk_discount_path(params[:merchant_id], params[:id])
  end

  private

  def bulk_discount_params
    params.permit(:quantity, :percentage, :merchant_id, :name)
  end

end