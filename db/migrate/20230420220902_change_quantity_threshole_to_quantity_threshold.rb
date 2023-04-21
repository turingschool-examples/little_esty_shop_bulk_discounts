class ChangeQuantityThresholeToQuantityThreshold < ActiveRecord::Migration[5.2]
  def change
    rename_column :bulk_discounts, :quantity_threshole, :quantity_threshold
  end
end
