# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: builds
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  street_id   :integer
#  porch_count :integer
#

# -*- encoding : utf-8 -*-
class Build < ActiveRecord::Base
	include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

    attr_accessible :name, :street_id, :porch_count, :node_id
    validates  :name, presence: true#, uniqueness: true
    validates  :porch_count, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to:20 }

    belongs_to :street
    belongs_to :node

    has_many   :porches
    has_many   :lifts, :through => :porches

end
