class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.string :name, index: true
      t.text :description

      t.timestamps
    end
  end
end
