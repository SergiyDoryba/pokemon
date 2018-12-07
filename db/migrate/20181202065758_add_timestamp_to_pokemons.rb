class AddTimestampToPokemons < ActiveRecord::Migration[5.2]
  def change
    change_table :pokemons do |t|
      t.timestamps
    end
  end
end
