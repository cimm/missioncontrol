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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120104075459) do

  create_table "clients", :force => true do |t|
    t.string   "nickname",   :null => false
    t.string   "name"
    t.string   "street"
    t.string   "postcode"
    t.string   "city"
    t.string   "country"
    t.string   "vat_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
  end

  add_index "clients", ["language"], :name => "index_clients_on_language"
  add_index "clients", ["nickname"], :name => "index_clients_on_nickname"

  create_table "expenses", :force => true do |t|
    t.string   "number",                                    :null => false
    t.string   "reference"
    t.string   "company",                                   :null => false
    t.decimal  "amount",      :precision => 8, :scale => 2, :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "number",     :null => false
    t.date     "payed_at"
    t.date     "owed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["number"], :name => "index_invoices_on_number", :unique => true

  create_table "preferences", :force => true do |t|
    t.string   "setting",    :null => false
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["setting"], :name => "index_preferences_on_setting"

  create_table "projects", :force => true do |t|
    t.string   "name",                                       :null => false
    t.integer  "client_id",                                  :null => false
    t.decimal  "default_rate", :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"

  create_table "units", :force => true do |t|
    t.date     "executed_at",                               :null => false
    t.decimal  "hours_spent", :precision => 4, :scale => 2, :null => false
    t.integer  "project_id",                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id"
  end

  add_index "units", ["invoice_id"], :name => "index_units_on_invoice_id"
  add_index "units", ["project_id"], :name => "index_units_on_project_id"

end
