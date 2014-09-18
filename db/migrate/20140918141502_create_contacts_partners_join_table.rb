class CreateContactsPartnersJoinTable < ActiveRecord::Migration
  def change
  	create_table :contacts_partners, id: false do |t|
    	t.integer :contact_id
    	t.integer :partner_id
    end
    add_index :contacts_partners, :contact_id
    add_index :contacts_partners, :partner_id
  end
end
