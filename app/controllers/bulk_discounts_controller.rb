class BulkDiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_bulk_discount, only: [:show, :destroy, :edit, :update]


  def index
  end

  def new
  end

  def edit
  end

  def update
    if @bulk_discount.update(discount_params)
      flash[:notice] = "Bulk discount has been updated!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:notice] = "Unable to update bulk discount!"
      render 'update'
    end
  end

  def show
  end

  def create
    @bulk_discount = BulkDiscount.new(discount_params)
    if @bulk_discount.save
      flash[:notice] = "New bulk discount has been created!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:notice] = "Unable to create bulk discount!"
      render 'new'
    end
  end

  def destroy
    if @bulk_discount.delete
      flash[:notice] = "Bulk discount has been removed!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:notice] = "Unable to remove bulk discount!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    end
  end

private

  def discount_params
    params[:percentage_discount] = params[:percentage_discount].to_f / 100
    params.permit(:name, :percentage_discount, :quantity_threshold, :merchant_id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end
