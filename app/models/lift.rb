# == Schema Information
#
# Table name: lifts
#
#  id                :integer          not null, primary key
#  node_id           :integer
#  porch_id          :integer
#  build_id          :integer
#  street_id         :integer
#  regnum            :string(255)
#  sernum            :string(255)
#  manufacturer      :string(255)
#  capacity          :integer
#  stopscount        :integer
#  owner             :string(255)
#  contract          :string(255)
#  introduced_at     :integer
#  overhaul_at       :integer
#  standart_life     :integer
#  end_of_service_at :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  lifttype          :string(255)
#

# -*- encoding : utf-8 -*-
class Lift < ActiveRecord::Base
    attr_accessible :node_id, :porch_id, :build_id, :street_id, :regnum, :sernum, :manufacturer, :lifttype, :capacity, :stopscount, 
    		:owner, :contract, :introduced_at, :overhaul_at, :standart_life, :end_of_service_at	
  
    belongs_to :porch
    belongs_to :node
    has_many :equip_pool
    #belongs_to :build
    #belongs_to :street
end
