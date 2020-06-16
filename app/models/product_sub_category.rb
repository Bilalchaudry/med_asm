class ProductSubCategory < ApplicationRecord
  belongs_to :product_category
  belongs_to :product
end
