# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: streets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Street < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: true
  #has_many :builds, :nodes
  cattr_reader :per_page
  @@per_page = 10

  
end
