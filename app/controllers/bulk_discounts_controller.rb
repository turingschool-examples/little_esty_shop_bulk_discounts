class BulkDiscountsController < ApplicationController
  before_action :find_bulk_discount, only: [:show]
  def show
  end

  private

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end
