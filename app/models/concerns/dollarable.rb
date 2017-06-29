module Dollarable
  extend ActiveSupport::Concern

  def unit_price
    convert_to_dollars(attributes['unit_price'])
  end

  private
    def convert_to_dollars(cents)
      (cents.to_f/100).to_s
    end
end
