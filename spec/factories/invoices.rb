FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    created_at "2017-06-26 00:00:00"
    updated_at "2017-06-26 00:00:00"

  end

  trait :with_transactions do
    transient { transaction_count 1 }

    after(:create) do |invoice, evaluator|
      invoice.transactions << create_list(:transaction, evaluator.transaction_count)
    end
  end
end
