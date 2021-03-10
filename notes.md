You need to order discounts by quantity threshold and then you need to get bulk discount where quanity_threshold <= item count

class  merchant
  def order_discounts
    discounts.order(:quantity_threshold)
  end

  def order_invoice_item
    .invoices_items
    .select(invoice_item.*)
    .order(:quantity)
  end
end

I want a method where I can have all the discounts, and then I can put in all the invoice items, and only return the ones that qualify for the discounts

I need to read through the part where it goes through how the algorithm is going to work

When the total gets summed, I need to pull out the list where for the ones that qualify and total it based on



What tables do I need?
Invoices
invoice_items (quantity and unit price)
Discounts(percent_discount and threshold)




#returns only invoices that qualify for at least one discount
where('invoice_items.quantity >= ?', discounts.quantity_threshold)
# apply discounts, sum them and return as total_discount
.select(quantity * invoice_item.unit_price * (percent_discount/100) as discounted_revenue)

.order(total_discount: :desc)


have a method that returns a joins table for all the items that qualify for at least one discount.

iterate through each invoice_item and see if it exists in the joins table, if so order by lowest discounted revenue
and use distinct to get the best deal
















select(:invoice_items
