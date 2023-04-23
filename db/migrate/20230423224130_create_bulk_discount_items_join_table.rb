class CreateBulkDiscountItemsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :bulk_discounts, :items do |t|
       t.index [:bulk_discount_id, :item_id]

       t.timestamps
    end
  end
end
