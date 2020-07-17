json.message "success"
json.success true
json.slots @all_slots.each do |user_slot|
  json.id user_slot.id
  json.day_time user_slot.day_time
  json.slot_time user_slot.slot_time.squish
  json.slot_status user_slot.slot_status
end