# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: streets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#

class Street < ActiveRecord::Base
  attr_accessible :name, :city_id
  validates  :name, presence: true, uniqueness: {case_sensitive: false}, length: { minimum: 5 }

  belongs_to :city

  has_many   :builds
  has_many   :porches, through: :builds
  has_many   :lifts, through: :porches
  #has_many :lifts, through: :builds

  def self.search(search)
    if search
      find(:all, :conditions => ['LOWER(name) LIKE ?', "%#{search.downcase}%"])
    else
      find(:all)
    end
  end
end
