# == Schema Information
#
# Table name: equipment
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Equipment < ActiveRecord::Base
  attr_accessible :name
end
