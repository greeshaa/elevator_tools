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
    attr_accessible :name, :street_id, :porch_count, :node_id
    validates  :name, presence: true#, uniqueness: true
    validates  :porch_count, presence: true

    belongs_to :street
    belongs_to :node

    has_many   :porches
    has_many   :lifts, :through => :porches

end
