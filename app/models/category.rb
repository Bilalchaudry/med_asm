class Category < ApplicationRecord

  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories

  validates_presence_of :name, :description
  validates_uniqueness_of :name

end
