# == Schema Information
#
# Table name: nodes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  street_id   :integer
#  build_id    :integer
#  porch_id    :integer
#  dataport    :integer
#  soundport   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# -*- encoding : utf-8 -*-
class Node < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  attr_accessible :name, :description, :street_id, :build_id, :porch_id, :dataport, :soundport, :ip_addresses_attributes

  belongs_to :porch
  belongs_to :build
  belongs_to :street

  has_many :equipment
  has_many :ip_addresses
  has_many :connections
  has_many :lifts
  has_many :porches, :through => :lifts
  has_many :builds, :through => :porches
  has_many :streets, :through => :builds


  accepts_nested_attributes_for :equipment
  accepts_nested_attributes_for :ip_addresses

  def self.order_by_name
    order('name DESC').sort
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])

      #street = Street.find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      #if street.empty?
      #  find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      #else
      #  @f1 = 'name LIKE ?'
      #  @f2 = '%#{search}%'
      #  street.each do |s|
       #   @f1 += " OR street_id = ?"
       #   @f2 += (', ' + s.id.to_s)
       # end
        #find(:all, :conditions => [ @f1, @f2 ])
      #end

    end
  end
end
