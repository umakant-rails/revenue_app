class CreateBlankForms < ActiveRecord::Migration[7.0]
  def change
    create_table :blank_forms do |t|
      t.integer :department_id
      t.string  :eng_name
      t.string  :hindi_name
      t.string  :category
      t.text    :content

      t.timestamps
    end
  end
end
