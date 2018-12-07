class AddFieldsPokemons < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemons, :description, :text
    add_column :pokemons, :parsed_data, :jsonb, default: {}, null: false

    # Add Ability level
    add_column :pokemons, :hp, :string
    add_column :pokemons, :attack, :string
    add_column :pokemons, :defense, :string
    add_column :pokemons, :special_attack, :string
    add_column :pokemons, :special_defence, :string
    add_column :pokemons, :speed, :string

    add_index :pokemons, :identifier

    add_index :pokemons, :hp
    add_index :pokemons, :attack
    add_index :pokemons, :defense
    add_index :pokemons, :special_attack
    add_index :pokemons, :special_defence
    add_index :pokemons, :speed
    add_index :pokemons, :parsed_data, using: :gin
  end
end
