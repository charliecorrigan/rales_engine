class Merchant < ApplicationRecord
  has_many :items

  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

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

  # has_many :invoice_items, through: :invoices

  def self.customers_with_pending_invoices(id)
    select("customers.*")
    .where("merchants.id = ?", id)
    .joins(:customers)
    .where("customers.id NOT IN (?)",
      Customer.joins(:transactions)
              .select("customers.id")
              .where("transactions.result = ?", 'success')
              .pluck(:id)
    ).group("customers.id")
  end

  def favorite_customer
    customers
    .select("customers.*")
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("count(transactions.id) DESC")
    .first
  end
end
