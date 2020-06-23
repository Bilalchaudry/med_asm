class Product < ApplicationRecord

  has_many :product_categories, dependent: :destroy
  has_many :product_categories, through: :product_categories


  has_many :order_products
  has_many :orders, through: :order_products


  validates_presence_of :name, :cost, :quantity

end