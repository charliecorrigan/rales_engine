class Item < ApplicationRecord
  include Dollarable

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(id: :asc) }

  def self.most_revenue(quantity = 1)
    unscoped.joins(:invoice_items)
      .select("items.*", "sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .group(:id)
      .order("total_revenue DESC")
      .take(quantity.to_i)
  end

  def best_day
    invoices.
    select("invoices.created_at, sum(invoice_items.quantity) AS total_sold").
    joins(:invoice_items, :transactions).
    merge(Transaction.successful).
    group(:id, "invoices.created_at").
    order("total_sold DESC, invoices.created_at DESC").
    limit(1).
    first.created_at
  end

  def self.most_items(quantity)
    unscoped.
    select("items.*, sum(invoice_items.quantity) AS total_sold").
    joins(:invoice_items, invoices: [:transactions]).
    merge(Transaction.successful).
    group(:id).
    order("total_sold DESC").
    limit(quantity)
  end
end
