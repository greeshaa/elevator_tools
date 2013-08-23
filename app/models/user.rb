# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :name, :email, :runame, :password, :password_confirmation
  has_secure_password 

  before_save { name.downcase! }
  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 24 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX }, 
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
end
