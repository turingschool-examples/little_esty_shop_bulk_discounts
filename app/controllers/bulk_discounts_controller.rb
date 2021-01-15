class BulkDiscountsController < ApplicationController

    def index
        @merchant = Merchant.find(params[:merchant_id])
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
    end

end
