class BulkDiscountsController < ApplicationController
before_action :find_merchant, only: [:index, :new, :create]
before_action :find_discount_and_merchant, only: [:show, :update]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
    # @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def edit
  end

  def update
  end


  def create
    # find_merchant
    discount = BulkDiscount.new(bulk_discount_params)
    if discount.save
      # flash[:success]= "New Discount Created"
      redirect_to merchant_bulk_discounts_path(@merchant), notice: "New Discount Created"
    else
      redirect_to new_merchant_bulk_discount_path(@merchant), notice: "Invalid input. Use only positive integers"
    end
  end

  def destroy
  end

  private

  def bulk_discount_params
    params.permit(:percent, :threshold, :merchant_id)
  end

  def find_discount_and_merchant
      @bulk_discount = BulkDiscount.find(params[:id])
      @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

end