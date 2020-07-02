json.message "success"
json.success true
json.data @prescriptions.each do |prescription|
  if prescription.status == 'Proceed'
    json.id prescription.id
    json.medicines prescription.order.order_products.each do |product|
      json.medicine_name product.product.name
      json.medicine_quantity product.quantity
      json.medicine_price product.price
      json.medicine_time product.timing
      json.morning_dose product.dose_quantity
      json.morning_dose_comment product.comment

      json.noon_time product.noon_time
      json.noon_dose product.noon_dose
      json.noon_dose_comment product.noon_instructions

      json.evening_time product.evening_time
      json.evening_dose product.evening_dose
      json.evening_dose_comment product.evening_instruction

      days = (product.end_date - product.start_date).to_i + 1
      json.days days

    end
    json.total_amount prescription.order.total_amount rescue nil
  else
    json.id prescription.id
    json.medicines []
  end
end