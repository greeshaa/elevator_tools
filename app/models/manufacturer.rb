# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: manufacturers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Manufacturer < ActiveRecord::Base
  attr_accessible :description, :short_name, :full_name
  #has_many :lift_types
  #has_many :lifts
end