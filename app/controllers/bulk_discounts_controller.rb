class BulkDiscountsController < ApplicationController
  
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)
    if bulk_discount.save
      flash[:notice] = "Bulk discount created successfully"
      redirect_to [@merchant, :bulk_discounts]
    else 
     flash[:notice] = bulk_discount.errors.full_messages
      render :new
    end 
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = @merchant.bulk_discounts.find(params[:id])
    bulk_discount.update(bulk_discount_params)
    if bulk_discount.save
      redirect_to [@merchant, :bulk_discount]
      flash[:notice] = "Discount ##{params[:id]} updated"
    else
      flash[:notice] = bulk_discount.errors.full_messages
      redirect_to edit_merchant_bulk_discount_path(@merchant, bulk_discount)
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
    @bulk_discount.destroy
    redirect_to [@merchant, :bulk_discounts]
    flash[:notice] = "Discount #{params[:id]} was deleted"
  end
end


private
def bulk_discount_params
  params.permit(:percentage_discount, :quantity_threshold)
end