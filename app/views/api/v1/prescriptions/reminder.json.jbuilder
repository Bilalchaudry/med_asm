json.message "success"
json.success true
json.medicine_reminder @user_reminders.each do |reminder|
    json.medicine_name reminder.order_product.product.name rescue "N/A"
    json.medicine_type reminder.order_product.product_type
    med_days = (reminder.end_date - reminder.start_date).to_i + 1
    json.days med_days
    json.medicine_time reminder.timing
    json.time reminder.time.strftime( "%H:%M:%S" )
    json.medicine_dose reminder.dose_quantity
    json.medicine_dose_comment reminder.comment
    json.reminder_date Date.today
    reminder_day = (Date.today - reminder.start_date).to_i + 1
    json.reminder_day reminder_day
    json.start_date reminder.start_date
    json.end_date reminder.end_date
end