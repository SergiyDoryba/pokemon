class CreatePokemon < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
        t.string :identifier
        t.string :species_id
        t.string :height
        t.string :weight
        t.string :base_experience
        t.string :order
        t.boolean :is_default
    end
  end
end
