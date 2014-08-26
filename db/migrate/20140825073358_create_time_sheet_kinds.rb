class CreateTimeSheetKinds < ActiveRecord::Migration
  def change
    create_table :time_sheet_kinds do |t|
      t.string :title
      t.string :letter_code
      t.integer :number_code

      t.timestamps
    end
  end
end
