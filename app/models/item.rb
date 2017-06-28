class Item < ApplicationRecord
  include Dollarable

  belongs_to :merchant
  has_many :invoice_items

  default_scope { order(id: :asc) }

  def self.most_revenue(quantity = 1)
    unscoped.joins(:invoice_items)
      .select("items.*", "sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .group(:id)
      .order("total_revenue DESC")
      .take(quantity.to_i)
  end
end
