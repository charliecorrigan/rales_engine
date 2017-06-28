class Item < ApplicationRecord
  include Dollarable

  belongs_to :merchant
  has_many :invoice_items

  default_scope { order(id: :asc) }
end
