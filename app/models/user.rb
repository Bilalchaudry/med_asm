# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :save_addresses
  has_many :prescriptions
  has_many :orders
  has_many :reminders
  has_many :slots
  has_one_attached :image

  enum gender: {
      Male: 0,
      Female: 1
  }
  enum blood_group: {
      'A+': 0,
      'A-': 1,
      'B+': 2,
      'B-': 3,
      'O+': 4,
      'O-': 5,
      'AB+': 6,
      'AB-': 7
  }
  scope :email_or_phone_exist?, ->(login) {where("email = ? OR  phone = ? ", login, login)}
  # validates_uniqueness_of :phone
  # validates_presence_of :full_name, :phone, :gender, :email
  # validates_uniqueness_of :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
