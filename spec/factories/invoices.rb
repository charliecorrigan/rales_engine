FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    created_at "2017-06-26 00:00:00"
    updated_at "2017-06-26 00:00:00"

    factory :invoice_with_invoice_items do
      transient do
        invoice_item_count 10
      end

      after(:create) do |invoice, evaluator|
        invoice.invoice_items << create_list(:invoice_item, evaluator.invoice_item_count)
      end
    end
  end
end
