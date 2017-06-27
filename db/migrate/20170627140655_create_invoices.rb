class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :merchant_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
