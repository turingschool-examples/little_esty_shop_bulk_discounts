class BulkDiscountsController < ApplicationController
    before_action :find_merchant
    before_action :find_bulk_discount, only: [:show, :edit, :update, :destroy]

    def index
        @discounts = BulkDiscount.all
    end

    def show
    end

    def edit
    end

    def update
        @discount.update(discount_params)
        redirect_to merchant_bulk_discount_path(@merchant, @discount)
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

    def destroy
        if @merchant.invoices.in_progress_with_discount(@discount.threshold).count > 0
            flash.notice = "Cannot delete this discount while applicable invoices are pending"
            redirect_to merchant_bulk_discounts_path(@merchant)      
        else
            BulkDiscount.destroy(params[:id])
            redirect_to merchant_bulk_discounts_path(@merchant)
        end
    end

    private
    def discount_params
        params.require(:bulk_discount).permit(:name, :discount, :threshold, :merchant_id)
    end

    def find_merchant
        @merchant = Merchant.find(params[:merchant_id])
    end

    def find_bulk_discount
        @discount = BulkDiscount.find(params[:id])
    end

end