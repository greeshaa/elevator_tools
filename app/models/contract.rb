# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: contracts
#
#  id         :integer          not null, primary key
#  partner_id :integer
#  number     :string(255)
#  signed_at  :date
#  lifetime   :date
#  note       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# -*- encoding : utf-8 -*-
class Contract < ActiveRecord::Base
  attr_accessible :lifetime, :note, :number, :signed_at
  belongs_to :partner
  has_many :lifts
end
