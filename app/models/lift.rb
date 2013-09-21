# == Schema Information
#
# Table name: lifts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lift < ActiveRecord::Base
  # attr_accessible :title, :body
end
