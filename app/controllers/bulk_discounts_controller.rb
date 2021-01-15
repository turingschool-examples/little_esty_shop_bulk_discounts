class BulkDiscountsController < ApplicationController
    before_action :find_merchant, only: [:new, :create, :index]

    def index
        @discounts = BulkDiscount.all
    end

    def show
        @discount = BulkDiscount.find(params[:id])
    end

    def edit
    end

    def update
    end

    def new
    end

    def create
        BulkDiscount.create!(name: params[:name],
                        discount: params[:discount],
                        threshold: params[:threshold],
                        merchant: @merchant)
                        # id: find_new_id)
        redirect_to merchant_bulk_discounts_path(@merchant)
    end

    private
    def discount_params
        params.require(:discount).permit(:name, :discount, :threshold, :merchant_id)
    end

    def find_merchant
        @merchant = Merchant.find(params[:merchant_id])
    end

end
