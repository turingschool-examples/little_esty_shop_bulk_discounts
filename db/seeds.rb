@merchant1 = Merchant.create!(name: 'Hair Care')
@bulk_discount1 = BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 5, merchant_id: @merchant1.id)

