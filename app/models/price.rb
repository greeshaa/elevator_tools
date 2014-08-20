# == Schema Information
#
# Table name: prices
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  cost        :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#

# -*- encoding : utf-8 -*-
class Price < ActiveRecord::Base
	include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

	attr_accessible :title, :description, :cost
end
