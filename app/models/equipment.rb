# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  equipment_list_id :integer
#  factory_sn        :string(255)
#  installed_at      :date
#  notes             :string(255)
#  destination_id    :integer
#  node_id           :integer
#  lift_id           :integer
#

# -*- encoding : utf-8 -*-
class Equipment < ActiveRecord::Base
  attr_accessible :equipment_list_id, :factory_sn, :notes, :destination_id, :installed_at, :porch_id

  before_save { factory_sn.upcase! }
 
  validates :factory_sn, presence: true, uniqueness: true

  belongs_to :equipment_list
  belongs_to :porch
  belongs_to :node
  belongs_to :lift
  has_many   :equipment_line_items
  has_many 	 :equipment_movements


  def self.search(search)
    if search
      find(:all, :conditions => ['factory_sn LIKE ?', "%#{search}%"])
    end
  end
end
