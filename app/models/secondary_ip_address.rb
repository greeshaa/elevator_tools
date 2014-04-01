# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: secondary_ip_addresses
#
#  id          :integer          not null, primary key
#  ip          :string(255)
#  mask        :string(255)
#  gate        :string(255)
#  provider_id :integer
#  node_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SecondaryIpAddress < ActiveRecord::Base
  attr_accessible :gate, :ip, :mask
  belongs_to :provider
  belongs_to :node
end
