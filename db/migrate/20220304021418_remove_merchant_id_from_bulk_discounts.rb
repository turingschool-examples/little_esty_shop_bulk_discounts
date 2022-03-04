class RemoveMerchantIdFromBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :bulk_discounts, :merchant_id, :integer
  end
end
