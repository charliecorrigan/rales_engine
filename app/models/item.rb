class Item < ApplicationRecord
  include Dollarable

  belongs_to :merchant
  has_many :invoice_items
end
