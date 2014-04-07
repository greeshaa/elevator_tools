# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: nodes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  street_id   :integer
#  build_id    :integer
#  porch_id    :integer
#

# -*- encoding : utf-8 -*-

class Node < ActiveRecord::Base
  attr_accessible :name, :description, :street_id, :build_id
  belongs_to :porch
  belongs_to :build
  belongs_to :street
  has_many :equipment
  has_many :lifts
  has_many :builds
  has_many :ip_address
  

  cattr_reader :per_page
  @@per_page = 21


  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    end
  end
end
