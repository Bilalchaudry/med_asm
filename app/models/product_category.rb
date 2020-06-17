class ProductCategory < ApplicationRecord
  has_many :product_sub_categories
  has_many :products, through: :product_sub_categories
  validates_presence_of :name, :description
  validates_uniqueness_of :name
end
