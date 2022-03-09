class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    # This is annoying
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    discount = BulkDiscount.create(
      percent: params[:discount],
      threshold: params[:threshold],
      merchant_id: params[:merchant_id]
    )

    discount.save

    redirect_to "/merchant/#{params[:merchant_id]}/bulk_discounts"
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])

    discount.destroy

    redirect_to "/merchant/#{merchant.id}/bulk_discounts"
  end
end
