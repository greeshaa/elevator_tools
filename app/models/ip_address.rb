# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: ip_addresses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  ip          :string(255)
#  mask        :string(255)
#  gate        :string(255)
#  node_id     :integer
#  provider_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class IpAddress < ActiveRecord::Base
	attr_accessible :ip, :gate, :mask, :connection_id, :provider_id
  belongs_to :provider
  #belongs_to :node
  belongs_to :connection

  validates :ip, presence: true
end
