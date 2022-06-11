BulkDiscount.destroy_all
merchant1 = Merchant.find(1)
@discount1 = BulkDiscount.create(percent: 10, threshold: 100, merchant_id: 1)
@discount2 = BulkDiscount.create(percent: 20, threshold: 200, merchant_id: 1)
@discount3 = BulkDiscount.create(percent: 30, threshold: 300, merchant_id: 1)
