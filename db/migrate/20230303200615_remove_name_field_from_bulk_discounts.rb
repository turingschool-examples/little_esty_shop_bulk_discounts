class RemoveNameFieldFromBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :bulk_discounts, :name, :string
  end
end
