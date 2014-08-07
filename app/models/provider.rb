# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: providers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  email      :string(255)
#  contact    :string(255)
#  note       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# -*- encoding : utf-8 -*-
class Provider < ActiveRecord::Base
  attr_accessible :contact, :email, :name, :note, :phone
  has_many :ip_addresses
  has_many :connections
  def self.order_by_name
    order('name ASC')
  end
end
