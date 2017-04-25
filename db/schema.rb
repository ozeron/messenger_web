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

ActiveRecord::Schema.define(version: 20170425124951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.json     "connection_parameters", default: {}
    t.string   "type"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",                     null: false
    t.text     "description", default: ""
    t.integer  "parent_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "mass_mailing_messages", force: :cascade do |t|
    t.integer  "mass_mailing_id"
    t.integer  "message_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "mass_mailing_messages", ["mass_mailing_id"], name: "index_mass_mailing_messages_on_mass_mailing_id", using: :btree
  add_index "mass_mailing_messages", ["message_id"], name: "index_mass_mailing_messages_on_message_id", using: :btree

  create_table "mass_mailings", force: :cascade do |t|
    t.string   "title"
    t.integer  "message_id"
    t.datetime "started"
    t.datetime "finished"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "status",                 default: "pending"
    t.integer  "processed_node_counter", default: 0
    t.integer  "sender_id"
    t.integer  "span",                   default: 0
    t.integer  "comment_count",          default: 20
    t.string   "comment_strategy",       default: "default"
  end

  create_table "mass_mailings_nodes", force: :cascade do |t|
    t.integer "mass_mailing_id"
    t.integer "node_id"
    t.string  "status",          default: "pending"
    t.string  "status_text",     default: "pending"
    t.string  "type",            default: ""
  end

  add_index "mass_mailings_nodes", ["mass_mailing_id"], name: "index_mass_mailings_nodes_on_mass_mailing_id", using: :btree
  add_index "mass_mailings_nodes", ["node_id"], name: "index_mass_mailings_nodes_on_node_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "pic1_file_name"
    t.string   "pic1_content_type"
    t.integer  "pic1_file_size"
    t.datetime "pic1_updated_at"
    t.string   "pic1_remote",       default: ""
    t.string   "doc1_remote",       default: ""
    t.string   "doc1_file_name"
    t.string   "doc1_content_type"
    t.integer  "doc1_file_size"
    t.datetime "doc1_updated_at"
  end

  create_table "node_groups", force: :cascade do |t|
    t.integer "node_id"
    t.integer "group_id"
  end

  add_index "node_groups", ["node_id", "group_id"], name: "index_node_groups_on_node_id_and_group_id", unique: true, using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "name",                     null: false
    t.text     "description", default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "type"
    t.json     "options",     default: {}
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.json     "connection_parameters",  default: {}
    t.string   "language",               default: "uk"
    t.string   "permission",             default: "user"
    t.integer  "account_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
