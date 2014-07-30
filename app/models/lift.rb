# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: lifts
#
#  id                          :integer          not null, primary key
#  node_id                     :integer
#  porch_id                    :integer
#  position                    :string(255)
#  regnum                      :string(255)
#  sernum                      :string(255)
#  function                    :string(255)
#  stopscount                  :integer
#  capacity                    :integer
#  introduced_at               :integer
#  overhaul_at                 :integer
#  standart_life               :integer
#  lift_type_id                :integer
#  elevator_control_station_id :integer
#  contract_id                 :integer
#  mechanic_id                 :integer
#  inspection_at               :date
#  made_at                     :date
#  manufacturer_id             :integer
#  manufacturer                :string(255)
#  model                       :string(255)
#  doors                       :string(255)
#  speed                       :integer
#  elevation                   :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  tlr_id                      :integer
#  district_id                 :integer
#  service_payment             :string(255)
#  expert_id                   :integer
#

# -*- encoding : utf-8 -*-
class Lift < ActiveRecord::Base
    attr_accessible :node_id, :porch_id, :position, :lift_type_id, :elevator_control_station_id, :regnum, :sernum, 
    				:contract_id, :mechanic_id, :inspection_at, :stopscount, :introduced_at, :overhaul_at, :standart_life
  
    belongs_to :porch
    belongs_to :build
    belongs_to :street
    belongs_to :district
    belongs_to :city
    belongs_to :node
    belongs_to :mechanic
    belongs_to :contract
    belongs_to :expert
    belongs_to :tlr
    belongs_to :elevator_control_station
    belongs_to :price
    #belongs_to :manufacturer

    has_many :equipment
    has_many :inspections
    has_many :temp_serv_meches
    
    accepts_nested_attributes_for :inspections

    def self.search(search)
      if search
        find(:all, :conditions => ['regnum LIKE ? OR sernum LIKE ?', "%#{search}%", "%#{search}%"])
      end
    end

    def self.to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |lift|
          csv << lift.attributes.values_at(*column_names)
        end
      end
    end
end
