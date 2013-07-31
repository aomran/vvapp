# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130731020857) do

  create_table "annual_submissions", force: true do |t|
    t.string   "cv"
    t.string   "artist_statement"
    t.string   "expo_project"
    t.string   "special_needs"
    t.string   "image_list"
    t.integer  "artist_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "annual_submissions", ["artist_id"], name: "index_annual_submissions_on_artist_id"

end
