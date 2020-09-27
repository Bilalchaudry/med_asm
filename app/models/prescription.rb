class Prescription < ApplicationRecord
  has_one_attached :image

  has_one :order
  has_many :comments
  belongs_to :user
  enum recuring_status: {
      No_Recuring: 0,
      Two_Weeks: 1,
      Four_Weeks: 2
  }
end
