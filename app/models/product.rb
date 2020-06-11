class Product < ApplicationRecord
  has_many :product_sub_categories
  has_many :product_categories, through: :product_sub_categories
end
