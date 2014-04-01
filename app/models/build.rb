# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: builds
#
#  id          :integer          not null, primary key
#  street_id   :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  node_id     :integer
#  porch_count :integer
#


class Build < ActiveRecord::Base
    attr_accessible :name, :street_id, :porch_count, :node_id
    validates :name, presence: true

    belongs_to :street
    belongs_to :node
    has_many :lifts, :through => :porches
    has_many :porches

end
