json.(item,
        :id,
        :name,
        :description,
        :merchant_id
      )
json.unit_price convert_to_dollars(item.unit_price)
