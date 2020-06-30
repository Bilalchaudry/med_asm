class Prescription < ApplicationRecord
  has_one_attached :image

  has_one :order
  has_many :comments
  belongs_to :user
end
