class Merchant < ApplicationRecord
  has_many :items

  has_many :invoices
  has_many :customers, through: :invoices

  has_many :invoice_items, through: :invoices

  def self.revenue(param_id)
    revenue = self.find_by_sql("SELECT m.id,
                                SUM(ii.unit_price * ii.quantity) total_revenue
                                FROM merchants m
                                INNER JOIN items i
                                ON m.id = i.merchant_id
                                INNER JOIN invoice_items ii
                                ON i.id = ii.item_id
                                WHERE m.id = #{param_id}
                                GROUP BY m.id").
                                first.
                                total_revenue
  end

end
