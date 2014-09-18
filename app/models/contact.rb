class Contact < ActiveRecord::Base
	attr_accessible :name, :function, :note, :phone_1, :phone_2, :e_mail, :partner_id
  belongs_to :partner
end
