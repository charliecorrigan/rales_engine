require 'csv'

namespace :import_csv do
  task :create_seed => :environment do
    Merchant.destroy_all
    Customer.destroy_all
    Invoice.destroy_all
    Transaction.destroy_all
    Item.destroy_all
    InvoiceItem.destroy_all

    merchants_text = File.read('../sales_engine/data/merchants.csv')
    csv = CSV.parse(merchants_text, :headers => true)
    csv.each do |row|
      # Merchant.create!(row.to_hash)
      Merchant.create!(name: row["name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"])
    end

    puts "Merchant seed complete"

    items_text = File.read('../sales_engine/data/items.csv')
    csv = CSV.parse(items_text, :headers => true)
    csv.each do |row|
      if !Merchant.find_by(id: row["merchant_id"])
        puts row
        break
      else
      # Item.create!(row.to_hash)
        Item.create!(name: row["name"],
                    description: row["description"],
                    unit_price: row["unit_price"],
                    merchant_id: row["merchant_id"],
                    created_at: row["created_at"],
                    updated_at: row["updated_at"])
      end
    end

    puts "Item seed complete"

    customers_text = File.read('../sales_engine/data/customers.csv')
    csv = CSV.parse(customers_text, :headers => true)
    csv.each do |row|
      # Customer.create!(row.to_hash)
      Customer.create!(last_name: row["last_name"],
                    first_name: row["first_name"],
                    created_at: row["created_at"],
                    updated_at: row["updated_at"])
    end

    puts "Customer seed complete"


    invoices_text = File.read('../sales_engine/data/invoices.csv')
    csv = CSV.parse(invoices_text, :headers => true)
    csv.each do |row|
      # Invoice.create!(row.to_hash)
      Invoice.create!(merchant_id: row["merchant_id"],
                  customer_id: row["customer_id"],
                  status: row["status"],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"])
    end

    puts "Invoice seed complete"

    invoice_items_text = File.read('../sales_engine/data/invoice_items.csv')
    csv = CSV.parse(invoice_items_text, :headers => true)
    csv.each do |row|
      # InvoiceItem.create!(row.to_hash)
      InvoiceItem.create!(item_id: row["item_id"],
                  invoice_id: row["invoice_id"],
                  unit_price: row["unit_price"],
                  quantity: row["quantity"],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"])
    end

    puts "InvoiceItem seed complete"

    transactions_text = File.read('../sales_engine/data/transactions.csv')
    csv = CSV.parse(transactions_text, :headers => true)
    csv.each do |row|
      # unless Invoice.find_by(id: row["invoice_id"]).nil?
        Transaction.create!(credit_card_number: row["credit_card_number"],
                            invoice_id: row["invoice_id"],
                            result: row["result"],
                            created_at: row["created_at"],
                            updated_at: row["updated_at"])
      # end
    end

    puts "Transaction seed complete"
  end
end 
