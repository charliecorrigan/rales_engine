class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def unit_price
    (attributes['unit_price'].to_f/100).to_s
  end
end
