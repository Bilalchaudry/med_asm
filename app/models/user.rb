# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :save_addresses
  has_many :prescriptions
  has_many :orders

  enum gender: {
      Male: 0,
      Female: 1
  }
  scope :email_or_phone_exist?, ->(login) {where("email = ? OR  phone = ? ", login, login)}
  # validates_uniqueness_of :phone
  # validates_presence_of :full_name, :phone, :gender, :email
  # validates_uniqueness_of :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
