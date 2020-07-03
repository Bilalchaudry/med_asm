json.message "success"
json.success true
json.data @prescriptions.each do |prescription|

  if prescription.order.present?
    json.id prescription.id
    json.medicines prescription.order.order_products.each do |product|
      json.medicine_name product.product.name rescue "N/A"
      json.medicine_tag product.product.medicine_tag rescue "N/A"
      json.medicine_type product.product_type
      json.medicine_quantity product.quantity
      json.medicine_price product.price
      days = (product.end_date - product.start_date).to_i + 1
      json.days days
      json.reminder product.reminders.each do |product|
          json.medicine_time product.timing
          json.medicine_dose product.dose_quantity
          json.medicine_dose_comment product.comment
          json.start_date product.start_date
          json.end_date product.end_date
      end
    end
    json.total_amount prescription.order.total_amount rescue nil
  else
    json.id prescription.id
    json.medicines []
  end
end