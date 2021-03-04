class RemoveMerchantFromInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :merchant_id
  end
end
