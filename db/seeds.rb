BulkDiscount.destroy_all

@bulk_discount5 = BulkDiscount.create!(percentage_discount: 0.05, quantity_threshold: 3, merchand_id: 26)
@bulk_discount10 = BulkDiscount.create!(percentage_discount: 0.10, quantity_threshold: 5, merchant_id: 26)
@bulk_discount20 = BulkDiscount.create!(percentage_discount: 0.15, quantity_threshold: 10, merchant_id: 26)
