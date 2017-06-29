class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant
  enum status: [:shipped]

  def created_at
    attributes['created_at'].strftime('%F %T')
  end

  def updated_at
    attributes['updated_at'].strftime('%F %T')
  end

  # def self.pending_invoices
  #   joins(:transactions)
  #    .where(:transactions:{result:'success'})
  #    .
  #
  # end
end
