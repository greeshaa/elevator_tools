# == Schema Information
#
# Table name: builds
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  street_id  :integer
#

# -*- encoding : utf-8 -*-
class Build < ActiveRecord::Base
	attr_accessible :name, :street_id
	validates :name, presence: true
    belongs_to :street
    has_many :nodes
end
