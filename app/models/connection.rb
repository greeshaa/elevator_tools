class Connection < ActiveRecord::Base
	attr_accessible :title, :porch_id, :provider_id, :ip_address_attributes
  belongs_to :porch
  #belongs_to :ip_address
  belongs_to :provider
  has_one   :ip_address

  accepts_nested_attributes_for :ip_address

  validates :title, presence: true
  validates :porch_id, presence: true
  validates :provider_id, presence: true

end
