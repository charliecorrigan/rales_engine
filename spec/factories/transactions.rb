FactoryGirl.define do
  factory :transaction do
    credit_card_number 1234123412341234
    result "success"
    created_at "2017-06-26 00:00:00"
    updated_at "2017-06-26 00:00:00"
  end
end
