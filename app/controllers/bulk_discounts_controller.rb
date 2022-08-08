class BulkDiscountsController < ApplicationController

  def index
    binding.pry
  end

end

### Merchant is linked to InvoiceItems
### Proof below
    #merchant = Merchant.find(params[:merchant_id])
    #merchant.invoice_items
    #x = merchant.invoice_items.where(invoice_id: 169)
    #x.sum(:quantity)