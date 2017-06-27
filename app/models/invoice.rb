class Invoice < ApplicationRecord
  enum status: [:shipped]
end
