class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.references :merchant
      t.integer :percent_discounted
      t.integer :quantity_threshold
      t.timestamps
    end
  end
end
