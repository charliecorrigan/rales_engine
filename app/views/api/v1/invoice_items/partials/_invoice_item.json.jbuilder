json.(invoice_item,
        :id,
        :item_id,
        :invoice_id,
        :quantity
      )
json.unit_price convert_to_dollars(invoice_item.unit_price)
