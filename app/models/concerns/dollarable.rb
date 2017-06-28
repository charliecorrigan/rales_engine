module Dollarable
  extend ActiveSupport::Concern

  def unit_price
    (attributes['unit_price'].to_f/100).to_s
  end
end
