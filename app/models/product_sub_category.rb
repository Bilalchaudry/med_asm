class ProductSubCategory < ApplicationRecord
  belongs_to :product_categories
  belongs_to :products
end
