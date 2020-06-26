class Order < ApplicationRecord


  belongs_to :prescription
  has_many :order_products
  has_many :products, through: :order_products

end
