class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.string :percent_discount
      t.integer :quantity_threshold
    end
  end
end
