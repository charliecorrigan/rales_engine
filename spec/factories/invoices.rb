FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    created_at "2017-06-26 00:00:00"
    updated_at "2017-06-26 00:00:00"
  end
end
