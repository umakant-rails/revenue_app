class CreateOrderTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :order_templates do |t|
      t.string  :category
      t.string  :name
      t.text    :template

      t.timestamps
    end
  end
end
