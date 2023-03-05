@merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @discount1 = BulkDiscount.create!(name: 'Cheap Things', percentage: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: 'Mythical Deals', percentage: 30, quantity_threshold:15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: 'Surplus Value', percentage: 40, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(name: 'Discount Galore', percentage: 50, quantity_threshold: 25, merchant_id: @merchant2.id)
