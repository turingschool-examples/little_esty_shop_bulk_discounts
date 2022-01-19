class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant_id = params[:merchant_id]
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant_id = params[:merchant_id]
  end

  def create
    new_discount = BulkDiscount.create(
      percentage: params[:percentage],
      threshold: params[:threshold],
      merchant_id: params[:merchant_id]
    )
    if new_discount.save
      redirect_to "/merchant/#{params[:merchant_id]}/discounts"
    else
      flash[:notice] = "Discount not created."
      redirect_to "/merchant/#{params[:merchant_id]}/discounts/new"
    end

  end

  def edit
    @merchant_id = params[:merchant_id]
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @bulk_discount = BulkDiscount.find(params[:bulk_discount_id])
    @bulk_discount.update(
      percentage: params[:percentage],
      threshold: params[:threshold]
    )
    redirect_to "/merchant/#{params[:merchant_id]}/discounts/#{params[:bulk_discount_id]}"
  end

  def destroy
    BulkDiscount.destroy(params[:discount_id])
    redirect_to "/merchant/#{params[:id]}/discounts"
  end
end
