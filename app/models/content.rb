class Content < ApplicationRecord
  validates :content, :page_type, presence: true
end
