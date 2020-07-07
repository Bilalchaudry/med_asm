json.message "success"
json.success true
json.data @prescriptions.each do |prescription|

  if prescription.order.present?
    json.id prescription.id
    json.medicines prescription.order.order_products.each do |order_product|
      json.medicine_name order_product.product.name rescue "N/A"
      json.medicine_tag order_product.product.medicine_tag rescue "N/A"
      json.medicine_type order_product.product_type
      json.medicine_quantity order_product.quantity
      json.medicine_price order_product.price
      days = (order_product.end_date - order_product.start_date).to_i + 1
      json.days days
      json.reminder order_product.reminders.each do |product|
        json.medicine_name order_product.product.name rescue "N/A"
        json.medicine_time product.timing
        json.time product.time
        json.medicine_dose product.dose_quantity
        json.medicine_dose_comment product.comment
        json.start_date product.start_date
        json.end_date product.end_date
      end
    end
    json.total_amount prescription.order.total_amount rescue nil
  end
end