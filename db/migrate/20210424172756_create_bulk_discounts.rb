class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.string :name
      t.float :percentage_discount
      t.integer :quantity_threshold
      t.datetime :created_at
      t.datetime :updated_at
      t.references :merchant, foreign_key: true
    end
  end
end
