class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue
    invoice_items.sum("unit_price * quantity * 0.8")
  end

  # def discounted_revenue
  #   self.bulk_discounts
  # Invoice.first.items.select("invoice_items.item_id, sum(invoice_items.quantity) as quant").group("invoice_items.item_id")
  # end

  # Invoice.first.bulk_discounts.select("invoice_items.item_id, sum(invoice_items.quantity * invoice_items.unit_price)").group("invoice_items.
  #   item_id")

  # Invoice.first.bulk_discounts.select("invoice_items.item_id, sum(invoice_items.quantity * invoice_items.unit_price)").group("invoice_ite
  #   ms.item_id").having("count(invoice_items.item_id) > 5")

  # Invoice.first.invoice_items.select("sum(invoice_items.quantity * invoice_items.unit_price) as rev, invoice_items.item_id").group("invoice_
  #   items.item_id")

  # SELECT  invoice_items.item_id, sum(invoice_items.quantity * invoice_items.unit_price)as revenue FROM "bulk_discounts" INNER JOIN "merchants" ON "bulk_discounts"."merchant_id" = "merchants"."id" INNER JOIN "items" ON "merchants"."id" = "items"."merchant_id" INNER JOIN "invoice_items" ON "items"."id" = "invoice_items"."item_id" WHERE "invoice_items"."invoice_id" = $1 GROUP BY invoice_items.item_id LIMIT $2 

  # ce_items.item_id")
  # Invoice Load (0.5ms)  SELECT  "invoices".* FROM "invoices" ORDER BY "invoices"."id" ASC LIMIT $1  [["LIMIT", 1]]
  # InvoiceItem Load (1.2ms)  SELECT sum(invoice_items.quantity * invoice_items.unit_price) as rev, invoice_items.item_id FROM "invoice_items" WHERE "invoice_items"."invoice_id" = $1 GROUP BY invoice_items.item_id  [["invoice_id", 1]]



   # def self.top_5_by_revenue
  #   Merchant.find_by_sql("
  #     SELECT invoice_items.*,
  #     SUM(invoice_items.quantity * invoice_items.unit_price ) AS revenue
  #     FROM invoice_items
  #     INNER JOIN items ON invoice_items.item_id= items.id
  #     INNER JOIN merchants ON items.merchant_id = merchants.id
  #     INNER JOIN bulk_discounts ON merchants.id = bulk_discounts.merchant_id
  #     HAVING SUM(invoice_items.quantity) > bulk_discounts.quantity_threshold
  #     GROUP BY invoice_items.item_id
  #     ")
  #   end
    

  # SELECT invoice_items.item_id,
  # SUM((invoice_items.quantity * invoice_items.unit_price) * 0.80) AS revenue
  # FROM invoice_items
  # INNER JOIN items ON invoice_items.item_id= items.id
  # INNER JOIN merchants ON items.merchant_id = merchants.id
  # INNER JOIN bulk_discounts ON merchants.id = bulk_discounts.merchant_id
  # GROUP BY invoice_items.item_id;
 
  

end
