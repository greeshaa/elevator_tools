class IpAddress < ActiveRecord::Base
	attr_accessible :name, :ip, :gate, :mask, :node_id, :provider_id
  belongs_to :provider
  belongs_to :node
end
