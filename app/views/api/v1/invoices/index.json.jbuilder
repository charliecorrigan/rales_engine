json.(@invoices) do |invoice|
  json.(invoice,
          :id,
          :customer_id,
          :merchant_id,
          :status,
          :created_at,
          :updated_at
        )
end
