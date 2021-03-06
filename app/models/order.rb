class Order < ApplicationRecord

  belongs_to :prescription
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  enum status: {
      Paid: 0,
      Under_preparation: 1,
      Completed: 2,
      Canceled: 3
  }

end
