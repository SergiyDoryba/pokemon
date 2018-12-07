# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_02_224955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_abilities_on_name"
  end

  create_table "evolutions", force: :cascade do |t|
    t.bigint "pokemon_id"
    t.integer "level"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id"], name: "index_evolutions_on_pokemon_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "identifier"
    t.string "species_id"
    t.string "height"
    t.string "weight"
    t.string "base_experience"
    t.string "order"
    t.boolean "is_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.jsonb "parsed_data", default: {}, null: false
    t.string "hp"
    t.string "attack"
    t.string "defense"
    t.string "special_attack"
    t.string "special_defence"
    t.string "speed"
    t.index ["attack"], name: "index_pokemons_on_attack"
    t.index ["defense"], name: "index_pokemons_on_defense"
    t.index ["hp"], name: "index_pokemons_on_hp"
    t.index ["identifier"], name: "index_pokemons_on_identifier"
    t.index ["parsed_data"], name: "index_pokemons_on_parsed_data", using: :gin
    t.index ["special_attack"], name: "index_pokemons_on_special_attack"
    t.index ["special_defence"], name: "index_pokemons_on_special_defence"
    t.index ["speed"], name: "index_pokemons_on_speed"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_types_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weaknesses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_weaknesses_on_name"
  end

  add_foreign_key "evolutions", "pokemons"
end
