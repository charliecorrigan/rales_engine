class Invoice < ApplicationRecord
  enum status: [:shipped]

  def created_at
    attributes['created_at'].strftime('%F %T')
    # Time.parse(attributes['created_at'].to_s)
  end

  def updated_at
    attributes['updated_at'].strftime('%FT%T.%LZ')
  end
end
