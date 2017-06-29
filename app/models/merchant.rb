class Merchant < ApplicationRecord
  extend Dollarable

  has_many :items

  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  has_many :invoice_items, through: :invoices

  def revenue
    total_revenue = invoices.joins(:invoice_items, :transactions).
                            where(transactions: { result: 'success' }).
                            sum("invoice_items.quantity * invoice_items.unit_price")
    cents_to_dollar(total_revenue)
  end

  def self.revenue_for_date(date)
    revenue = self.joins(invoices: [:invoice_items, :transactions])
                  .select("sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
                  .where(invoices: {created_at: date})
                  .merge(Transaction.successful)[0].total_revenue
    convert_to_dollars(revenue)
  end

  def self.most_revenue(quantity = 1)
    joins(:invoice_items)
    .select("merchants.*", "sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .group(:id)
    .order("total_revenue DESC")
    .take(quantity.to_i)
  end

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

  private
    def cents_to_dollar(cents)
      (cents.to_f/100).to_s
    end
end
