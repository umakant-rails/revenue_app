class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :eng_name
      t.string :hindi_name
      
      t.timestamps
    end
  end
end
