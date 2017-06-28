class InvoiceItem < ApplicationRecord
  include Dollarable

  belongs_to :item
  belongs_to :invoice
end
