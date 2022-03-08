class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
    @holidays = HolidayService.new
  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = Discount.new()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(discount_params)

    if discount.valid?
      merchant.discounts.push(discount)
      flash[:notice] = "#{discount.name} Has Been Created!"
      redirect_to merchant_discounts_path(merchant)
    else
      flash[:messages] = discount.errors.full_messages
      redirect_to new_merchant_discount_path(merchant)
    end
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    flash[:notice] = "#{discount.name} Has Been Deleted!"
    redirect_to merchant_discounts_path(params[:merchant_id])
  end

  def edit
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    discount = Discount.find(params[:id])
    discount.update(discount_params)

    if discount.valid?
      flash[:notice] = "Discount Has Been Updated!"
      redirect_to merchant_discount_path(params[:merchant_id], discount)
    else
      flash[:messages] = discount.errors.full_messages
      redirect_to edit_merchant_discount_path(params[:merchant_id], discount)
    end

  end

  private

  def discount_params
    params.permit(:name, :percent_discount, :threshold, :merchant_id)
  end


end
