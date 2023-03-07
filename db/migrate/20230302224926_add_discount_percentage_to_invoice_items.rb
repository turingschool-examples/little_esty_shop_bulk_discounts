class AddDiscountPercentageToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :discount, :integer, default: 0
  end
end
