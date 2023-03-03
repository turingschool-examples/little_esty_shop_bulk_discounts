class BulkDiscountsController < ApplicationController
  before_action :set_merchant
  
  def index
    @bulk_discounts = @merchant.bulk_discounts
  #   require 'pry'; binding.pry
  end

  private
  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end