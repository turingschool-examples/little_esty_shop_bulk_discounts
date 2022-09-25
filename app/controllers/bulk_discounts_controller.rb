class BulkDiscountsController < ApplicationController
  before_action :find_merchant

  def index
    # @bulk_discounts = BulkDiscount.all
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
  end

  def create
    bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)
    if bulk_discount.save
      flash.clear #sad test needed
      redirect_to [@merchant, :bulk_discounts]
    else
      flash.notice = "error"
      render :new
    end
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    discount.update(bulk_discount_params)
    if discount.save
      redirect_to [@merchant, discount]
    else
      # flash.notice = "All fields must be filled"
      redirect_to edit_merchant_item_path(@merchant, discount)
    end
  end

  def destroy
    BulkDiscount.destroy(params[:id])
    redirect_to [@merchant, :bulk_discounts]
  end

  private

  def bulk_discount_params
    params.permit(:percent_off, :quantity, :status)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
