class Invoice < ApplicationRecord
  has_many :transactions
  enum status: [:shipped]

  def created_at
    attributes['created_at'].strftime('%F %T')
  end

  def updated_at
    attributes['updated_at'].strftime('%F %T')
  end
end
