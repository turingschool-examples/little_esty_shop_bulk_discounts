class BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = @merchant.bulk_discounts
  end
end