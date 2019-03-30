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

ActiveRecord::Schema.define(version: 2019_03_30_122959) do

  create_table "matches", force: :cascade do |t|
    t.integer "homePoints"
    t.integer "awayPoints"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "state", default: 0
    t.integer "tournament_id"
    t.integer "match_no"
    t.integer "round_no"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tournament_id"
    t.index ["tournament_id"], name: "index_participants_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 0
    t.integer "type"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
