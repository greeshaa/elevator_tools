# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: streets
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  city_id        :integer
#  street_kind_id :integer
#

# -*- encoding : utf-8 -*-
class Street < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  attr_accessible :name, :city_id, :street_kind_id
  validates  :name, presence: true, uniqueness: {case_sensitive: false}

  belongs_to :city
  belongs_to :street_kind
  has_many   :builds
  has_many   :porches, through: :builds
  has_many   :lifts, through: :porches
  has_many   :nodes, through: :porches
  #has_many :lifts, through: :builds

  accepts_nested_attributes_for :city
  accepts_nested_attributes_for :street_kind

  def self.search(search)
    if search
      find(:all, :conditions => ['LOWER(name) LIKE ?', "%#{search.downcase}%"])
    else
      find(:all)
    end
  end
end
