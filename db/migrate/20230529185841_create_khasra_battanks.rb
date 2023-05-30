class CreateKhasraBattanks < ActiveRecord::Migration[7.0]
  def change
    create_table :khasra_battanks do |t|
      t.integer :khasra_id
      t.string  :new_khasra
      t.float   :rakba
      t.integer :request_id
      t.integer :participant_id

      t.timestamps
    end
  end
end
