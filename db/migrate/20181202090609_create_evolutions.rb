class CreateEvolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :evolutions do |t|
      t.references :pokemon, foreign_key: true
      t.integer :level
      t.text :description

      t.timestamps
    end
  end
end
