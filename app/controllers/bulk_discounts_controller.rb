class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])

    response = Faraday.new('https://date.nager.at/').get('api/v2/NextPublicHolidays/us')
    json = JSON.parse(response.body, symbolize_names: true)
    @holidays = json[0..2].map do |data|
      Holiday.new(data)
    end

  end

  def show
    @discount = BulkDiscount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @discount = BulkDiscount.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    bulk_discount = params[:bulk_discount]
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create(discount: bulk_discount[:discount], quantity: bulk_discount[:quantity], merchant: @merchant)
    redirect_to merchant_bulk_discounts_path
  end

  def destroy
    @merchant = Merchant.find_by(id: params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    discount.update(discount: params[:bulk_discount][:discount], quantity: params[:bulk_discount][:quantity])
    redirect_to "/merchant/#{discount.merchant.id}/bulk_discounts/#{discount.id}"
  end
end
