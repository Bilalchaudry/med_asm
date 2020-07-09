class OrderProduct< ApplicationRecord

  belongs_to :order
  belongs_to :product
  has_many :reminders, dependent: :destroy
end
