module ApplicationHelper
  def convert_to_dollars(cents)
    (cents.to_f/100).to_s
  end
end
