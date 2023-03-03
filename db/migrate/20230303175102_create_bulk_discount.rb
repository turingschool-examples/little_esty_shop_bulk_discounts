class CreateBulkDiscount < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.decimal :percentage_discount
      t.integer :quantity_threshhold
      t.references :merchant, foreign_key: true
      t.timestamps
    end
  end
end
