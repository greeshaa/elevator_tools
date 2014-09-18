class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :function
      t.string :note
      t.integer :phone_1
      t.integer :phone_2
      t.string :e_mail
      t.integer :partner_id

      t.timestamps
    end
  end
end
