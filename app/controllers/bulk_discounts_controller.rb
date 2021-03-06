class BulkDiscountsController < ApplicationController
  def index
  	@merchant = Merchant.find(params[:merchant_id])
  	# binding.pry
  end

  def show
  end
end 
