# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# -*- encoding : utf-8 -*-
class UsersGroup < ActiveRecord::Base
  attr_accessible :name
end
