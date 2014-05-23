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

ActiveRecord::Schema.define(version: 20140523005858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.integer  "total_visits", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paths", force: true do |t|
    t.integer  "total_traversals", default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "begin_node_id"
    t.integer  "end_node_id"
  end

  add_index "paths", ["begin_node_id"], name: "index_paths_on_begin_node_id", using: :btree
  add_index "paths", ["end_node_id"], name: "index_paths_on_end_node_id", using: :btree
  add_index "paths", ["total_traversals"], name: "index_paths_on_total_traversals", using: :btree

end
