class BulkDiscountsController < ApplicationController
  def index
  	@merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  # private

  # def bulk_discount_params
  # 	params.permit(:quantity_threshold, :percent_discount, :merchant_id)
  # end
end
