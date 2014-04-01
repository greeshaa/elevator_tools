# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: lifts
#
#  id                          :integer          not null, primary key
#  node_id                     :integer
#  porch_id                    :integer
#  regnum                      :string(255)
#  sernum                      :string(255)
#  stopscount                  :integer
#  introduced_at               :integer
#  overhaul_at                 :integer
#  standart_life               :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  position                    :string(255)
#  lift_type_id                :integer
#  elevator_control_station_id :integer
#  contract_id                 :integer
#  mechanic_id                 :integer
#  inspection_at               :date
#
class Lift < ActiveRecord::Base
    attr_accessible :node_id, :porch_id, :position, :lift_type_id, :elevator_control_station_id, :regnum, :sernum, 
    				:contract_id, :mechanic_id, :inspection_at, :stopscount, :introduced_at, :overhaul_at, :standart_life
  
    belongs_to :porch
    belongs_to :node
    belongs_to :build
    belongs_to :street
    belongs_to :mechanic
    belongs_to :contract
    belongs_to :elevator_control_station
    #belongs_to :manufacturer

    has_many :equipment
    has_many :inspections

    def self.search(search)
        if search
            find(:all, :conditions => ['regnum LIKE ? OR sernum LIKE ?', "%#{search}%", "%#{search}%"])
        end
    end

end
