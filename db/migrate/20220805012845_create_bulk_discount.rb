class CreateBulkDiscount < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :percentage
      t.integer :quantity
      t.references :merchant, foreign_key: true
    end
  end
end
