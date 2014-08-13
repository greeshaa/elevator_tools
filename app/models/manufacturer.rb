# == Schema Information
#
# Table name: manufacturers
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  short_name  :string(255)
#  full_name   :string(255)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class Manufacturer < ActiveRecord::Base
  attr_accessible :description, :short_name, :full_name
  #has_many :lift_types
  #has_many :lifts
end
