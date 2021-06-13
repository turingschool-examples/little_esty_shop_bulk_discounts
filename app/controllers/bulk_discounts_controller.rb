class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
    # @holidays = HolidayService.public_holidays[0..2]
  end


  def show
    @discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.where('id = ?', @discount.merchant_id)
  end

  def create

  end
end



  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.save
      redirect_to "/admin/merchants/#{@merchant.id}",
      error: "Merchant has been successfully updated"
    end
  end
