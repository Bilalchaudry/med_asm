json.message "success"
json.success true
json.morning do
  if @morning_slots.first.present?
    json.first_slot_time @morning_slots.first.slot_time
    json.first_slot_status @morning_slots.first.slot_status
  end
  if @morning_slots.second.present?
    json.second_slot_time @morning_slots.second.slot_time
    json.second_slot_status @morning_slots.second.slot_status
  end
  if @morning_slots.third.present?
    json.third_slot_time @morning_slots.third.slot_time
    json.third_slot_status @morning_slots.third.slot_status
  end
  if @morning_slots.fourth.present?
    json.fourth_slot_time @morning_slots.fourth.slot_time
    json.fourth_slot_status @morning_slots.fourth.slot_status
  end
end
json.noon do
  if @noon_slots.first.present?
    json.first_slot_time @noon_slots.first.slot_time
    json.first_slot_status @noon_slots.first.slot_status
  end
  if @noon_slots.second.present?
    json.second_slot_time @noon_slots.second.slot_time
    json.second_slot_status @noon_slots.second.slot_status
  end
  if @noon_slots.third.present?
    json.third_slot_time @noon_slots.third.slot_time
    json.third_slot_status @noon_slots.third.slot_status
  end
  if @noon_slots.fourth.present?
    json.fourth_slot_time @noon_slots.fourth.slot_time
    json.fourth_slot_status @noon_slots.fourth.slot_status
  end
end
json.evening do
  if @evening_slots.first.present?
    json.first_slot_time @evening_slots.first.slot_time
    json.first_slot_status @evening_slots.first.slot_status
  end
  if @evening_slots.second.present?
    json.second_slot_time @evening_slots.second.slot_time
    json.second_slot_status @evening_slots.second.slot_status
  end
  if @evening_slots.third.present?
    json.third_slot_time @evening_slots.third.slot_time
    json.third_slot_status @evening_slots.third.slot_status
  end
  if @evening_slots.fourth.present?
    json.fourth_slot_time @evening_slots.fourth.slot_time
    json.fourth_slot_status @evening_slots.fourth.slot_status
  end
end