class Reminder < ApplicationRecord
  belongs_to :order_product
  belongs_to :user
  enum timing: {
      Morning: 'Morning',
      Noon: 'Noon',
      Evening: 'Evening'
  }
end
