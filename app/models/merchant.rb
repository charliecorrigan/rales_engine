class Merchant < ApplicationRecord
  extend Dollarable
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def revenue(date = nil)
    if date.nil?
      total_revenue = invoices.joins(:invoice_items, :transactions).
                              merge(Transaction.successful).
                              sum("invoice_items.quantity * invoice_items.unit_price")
    else
      day = Date.parse(date)
      # total_revenue = invoices.joins(:invoice_items, :transactions).
      #                         merge(Transaction.successful).
      total_revenue = successful_merchant_transactions
                              .where(invoices: { created_at: day.midnight..day.end_of_day }).
                              sum("invoice_items.quantity * invoice_items.unit_price")
    end
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

  def customers_with_pending_invoices
    invoices.find_by_sql("
      SELECT m.id, c.* FROM merchants m
      INNER JOIN invoices i
      ON m.id = i.merchant_id
      INNER JOIN customers c
      ON c.id = i.customer_id
      INNER JOIN transactions t
      ON i.id = t.invoice_id
      WHERE m.id = #{self.id}

      EXCEPT
      SELECT m.id, c.* FROM merchants m
      INNER JOIN invoices i
      ON m.id = i.merchant_id
      INNER JOIN customers c
      ON c.id = i.customer_id
      INNER JOIN transactions t
      ON i.id = t.invoice_id
      WHERE t.result = 'success'
    ")
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

  def self.find_by_most_items(quantity)
    select("merchants.*, sum(invoice_items.quantity) AS number_of_items").
    joins(invoices: [:invoice_items, :transactions]).
    where(transactions: { result: 'success'}).
    group(:id).
    order("number_of_items DESC").
    limit(quantity)
  end

  def successful_merchant_transactions
    invoices.
    joins(:invoice_items, :transactions).
    merge(Transaction.successful)
  end
  private

  def cents_to_dollar(cents)
    (cents.to_f/100).to_s
  end
end
