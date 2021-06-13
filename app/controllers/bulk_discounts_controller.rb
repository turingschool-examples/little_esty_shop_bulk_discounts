class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.where('id = ?', @discount.merchant_id)
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    new_bd = @merchant.bulk_discounts.create!(bulk_discount_params)

    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    
    @merchant.bulk_discounts.find(params[:id]).destroy

    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  private
  def bulk_discount_params
    params.permit(:percent, :threshold)
  end
end



  #
  #
  # def update
  #   @merchant = Merchant.find(params[:id])
  #   @merchant.update(merchant_params)
  #   if @merchant.save
  #     redirect_to "/admin/merchants/#{@merchant.id}",
  #     error: "Merchant has been successfully updated"
  #   end
  # end
