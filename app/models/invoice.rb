class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  enum status: [:shipped]

  def created_at
    attributes['created_at'].strftime('%F %T')
  end

  def updated_at
    attributes['updated_at'].strftime('%F %T')
  end
end
