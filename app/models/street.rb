# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: streets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Street < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: { minimum: 5 }
  has_many :builds
  has_many :porches, through: :builds
  has_many :lifts, through: :porches
  #has_many :lifts, through: :builds

  def self.search(search)
    if search
      find(:all, :conditions => ['LOWER(name) LIKE ?', "%#{search.downcase}%"])
    else
      find(:all)
    end
  end
end
