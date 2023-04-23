InvoiceItem.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Customer.destroy_all
Merchant.destroy_all
Item.destroy_all

system('rake import')

@bulk_discount_1 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 5, merchant_id: 1)
@bulk_discount_2 = BulkDiscount.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: 1)
@bulk_discount_3 = BulkDiscount.create!(percentage_discount: 20, quantity_threshold: 15, merchant_id: 1)
@bulk_discount_4 = BulkDiscount.create!(percentage_discount: 25, quantity_threshold: 20, merchant_id: 1)
@bulk_discount_1 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 5, merchant_id: 2)
@bulk_discount_2 = BulkDiscount.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: 2)
@bulk_discount_3 = BulkDiscount.create!(percentage_discount: 20, quantity_threshold: 15, merchant_id: 2)
@bulk_discount_4 = BulkDiscount.create!(percentage_discount: 25, quantity_threshold: 20, merchant_id: 2)
