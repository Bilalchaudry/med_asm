class Product < ApplicationRecord
  has_many :product_sub_categories, dependent: :destroy
  has_many :product_categories, through: :product_sub_categories
end
