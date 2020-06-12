# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  scope :email_or_phone_exist?, ->(login) {where("email = ? OR  phone = ? ", login, login)}

  validates_uniqueness_of :phone

  has_many :save_addresses
end
