class SaveAddress < ApplicationRecord

  belongs_to :user
  has_one :additional_info, dependent: :destroy
  validates :latitude, :longitude, :address, presence: true
  accepts_nested_attributes_for :additional_info
end
