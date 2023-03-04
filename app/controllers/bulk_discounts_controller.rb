class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
end
