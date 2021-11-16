class DiscountsController < ApplicationController
  before_action :set_merchant
  before_action :set_discount, only: [:destroy, :edit, :update, :show]

  def index
    @discounts = Discount.all
    @holidays = HolidayFacade.create_holidays
  end

  def show
  end

  def new
    @discount = Discount.new
  end

  def create
    discount = @merchant.discounts.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash.notice = "All fields must be completed, get your act together."
      redirect_to new_merchant_discount_path(@merchant)
    end
  end

  def destroy
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  def edit
  end

  def update
    if @discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, @discount)
    else
      flash.notice = "All fields must be completed, get your act together."
      redirect_to edit_merchant_discount_path(@merchant, @discount)
    end
  end

    private

    def discount_params
      params.require(:discount).permit(:percentage_discount, :quantity_threshold)
    end

    def set_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    def set_discount
      @discount = Discount.find(params[:id])
    end
  end
