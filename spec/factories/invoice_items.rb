FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 1
    created_at "2017-06-26 00:00:00"
    updated_at "2017-06-26 00:00:00"
  end
end
