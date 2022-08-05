class DiscountsController < ApplicationController
   def index
      @discounts = Discount.all
      @merchant = Merchant.find(params[:merchant_id])
   end  
end
