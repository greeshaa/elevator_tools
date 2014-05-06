# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: porches
#
#  id         :integer          not null, primary key
#  build_id   :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Porch < ActiveRecord::Base
  attr_accessible :name, :build_id

  belongs_to :build
  belongs_to :street

  has_one  :node
  has_many :lifts
  has_many :equipment
  has_many :equipment_movements
end
