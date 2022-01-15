class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :min_quantity
      t.integer :percent_off
      t.references :merchant, foreign_key: true
    end
  end
end
