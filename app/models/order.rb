class Order < ApplicationRecord

  belongs_to :prescription
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  enum status: {
      Paid: 0,
      Under_prescription: 1,
      Completed: 2,
      Cancel: 3
  }

end
