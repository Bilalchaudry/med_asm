class Reminder < ApplicationRecord
  belongs_to :order_product
  belongs_to :user
  enum timing: {
      Morning: 0,
      Noon: 1,
      Evening: 2
  }
end
