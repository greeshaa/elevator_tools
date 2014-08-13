# == Schema Information
#
# Table name: foremen
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# -*- encoding : utf-8 -*-
class Foreman < ActiveRecord::Base
	attr_accessible :name, :user_id
	belongs_to :user
	has_many :mechanics
end
