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
#  created_at                  :datetime
#  updated_at                  :datetime
#  tlr_id                      :integer
#  district_id                 :integer
#  service_payment             :string(255)
#  expert_id                   :integer
#  price_id                    :integer
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Lift do
  pending "add some examples to (or delete) #{__FILE__}"
end
