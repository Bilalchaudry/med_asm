class AdditionalInfo < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :save_address, optional: true
end
