class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    invoices.
    select("merchants.name, merchants.id, count(invoices.id) AS num_of_successful_transactions").
    joins(:transactions, :merchant).
    where(transactions: { result: 'success' }).
    group("merchants.id").
    order("num_of_successful_transactions DESC").
    limit(1).first
  end
end
