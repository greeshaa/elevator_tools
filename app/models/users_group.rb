# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersGroup < ActiveRecord::Base
  attr_accessible :name
end
