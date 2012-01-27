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

ActiveRecord::Schema.define(:version => 20120127120845) do

  create_table "bags", :force => true do |t|
    t.integer  "bag_number"
    t.integer  "adding_transaction_id"
    t.integer  "removing_transaction_id"
    t.integer  "finished_good_id"
    t.float    "quantity"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => true
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "finished_good_transactions", :force => true do |t|
    t.string   "transaction_type"
    t.string   "reference_type"
    t.string   "reference_number"
    t.date     "transaction_date"
    t.float    "quantity"
    t.string   "lot_number"
    t.string   "dr_number"
    t.string   "si_number"
    t.integer  "start_bag_number"
    t.integer  "end_bag_number"
    t.integer  "finished_good_id"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.text     "comments"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "quantity_per_bag"
    t.float    "remainder_quantity"
  end

  create_table "finished_goods", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.integer  "unit_of_measure_id"
    t.integer  "customer_id"
    t.boolean  "local"
    t.text     "comments"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_material_transactions", :force => true do |t|
    t.string   "transaction_type"
    t.string   "reference_type"
    t.string   "reference_number"
    t.date     "transaction_date"
    t.float    "quantity"
    t.string   "lot_number"
    t.string   "po_number"
    t.string   "mirs_number"
    t.integer  "raw_material_id"
    t.integer  "issued_department_id"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.text     "comments"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "raw_material_types", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_materials", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.integer  "raw_material_type_id"
    t.integer  "unit_of_measure_id"
    t.integer  "supplier_id"
    t.boolean  "local"
    t.text     "comments"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "supplies", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "supply_type"
    t.text     "description"
    t.text     "comments"
    t.integer  "unit_of_measure_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supply_transactions", :force => true do |t|
    t.string   "transaction_type"
    t.date     "transaction_date"
    t.float    "quantity"
    t.string   "supplier_name"
    t.float    "unit_price"
    t.string   "usage"
    t.string   "rr_number"
    t.string   "pre_number"
    t.string   "mirs_number"
    t.string   "lot_number"
    t.integer  "supply_id"
    t.integer  "issued_department_id"
    t.integer  "issued_user_id"
    t.text     "comments"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_of_measures", :force => true do |t|
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
