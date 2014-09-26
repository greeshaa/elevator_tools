class Contact < ActiveRecord::Base
	attr_accessible :name, :function, :phone_1, :phone_2, :e_mail, :note

	has_and_belongs_to_many :partners, join_table: :contacts_partners

	validates  :name, presence: true, uniqueness: true
	validates  :function, presence: true
end
