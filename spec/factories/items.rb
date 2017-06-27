FactoryGirl.define do
  factory :item do
    name "MyString"
    description "MyString"
    unit_price 1
    merchant
    created_at "2017-06-26 00:00:00"
    updated_at "2017-06-26 00:00:00"
  end
end
