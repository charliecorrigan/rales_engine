class AddMerchantAndCustomerRelationshipsToInvoicess < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :merchant_id
    remove_column :invoices, :customer_id
    add_reference :invoices, :merchant, foreign_key: true
    add_reference :invoices, :customer, foreign_key: true
  end
end
