class SaveAddress < ApplicationRecord

  belongs_to :user
  validates :latitude, :longitude, :address, presence: true
end
