class AddNameFieldToBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    add_column :bulk_discounts, :promo_name, :string
    add_column :bulk_discounts, :created_at, :datetime
    add_column :bulk_discounts, :updated_at, :datetime
  end
end
