class CreateFormTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :form_templates do |t|
      t.string  :category
      t.string  :name
      t.text    :template
      
      t.timestamps
    end
  end
end
