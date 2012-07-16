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

ActiveRecord::Schema.define(:version => 20120716070106) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "bags", :force => true do |t|
    t.integer  "bag_number"
    t.integer  "removing_transaction_id"
    t.integer  "finished_good_id"
    t.decimal  "quantity",                          :precision => 11, :scale => 5
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "finished_good_transaction_item_id"
    t.string   "lot_number"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "active"
    t.boolean  "applicable_to_rm",                   :default => true
    t.boolean  "applicable_to_fg",                   :default => true
    t.boolean  "applicable_to_supplies_oc",          :default => true
    t.boolean  "applicable_to_supplies_engineering", :default => true
    t.boolean  "applicable_to_supplies_packaging",   :default => true
    t.boolean  "applicable_to_supplies_scrap",       :default => true
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => true
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "rm_rr",      :default => true
    t.boolean  "fg_tos",     :default => true
  end

  create_table "extruders", :force => true do |t|
    t.string   "name"
    t.string   "brand"
    t.boolean  "active",     :default => true
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "finished_good_transaction_items", :force => true do |t|
    t.string   "lot_number"
    t.integer  "start_bag_number"
    t.integer  "end_bag_number"
    t.decimal  "quantity",                     :precision => 11, :scale => 5
    t.boolean  "underpack",                                                   :default => false
    t.integer  "finished_good_transaction_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transaction_type"
  end

  create_table "finished_good_transactions", :force => true do |t|
    t.string   "transaction_type"
    t.string   "reference_type"
    t.string   "reference_number"
    t.date     "transaction_date"
    t.string   "dr_number"
    t.string   "si_number"
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
    t.string   "issue_type"
    t.integer  "issued_to_id"
    t.string   "issued_to_type"
    t.string   "mirs_number"
  end

  create_table "finished_goods", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "unit_of_measure_id"
    t.integer  "customer_id"
    t.boolean  "local"
    t.text     "comments"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "active",             :default => true
  end

  create_table "formula_items", :force => true do |t|
    t.decimal  "quantity",             :precision => 11, :scale => 5
    t.decimal  "multiplier",           :precision => 11, :scale => 5
    t.integer  "formula_id"
    t.integer  "raw_material_type_id"
    t.integer  "raw_material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formulas", :force => true do |t|
    t.string   "formula_type"
    t.boolean  "finished_good_local", :default => true
    t.integer  "finished_good_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issued_formula_items", :force => true do |t|
    t.integer  "issued_formula_id"
    t.integer  "raw_material_id"
    t.decimal  "big_batch_quantity",   :precision => 11, :scale => 5
    t.decimal  "small_batch_quantity", :precision => 11, :scale => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issued_formulas", :force => true do |t|
    t.string   "control_number"
    t.date     "issuance_date"
    t.boolean  "finished_good_local",                                       :default => true
    t.integer  "finished_good_id"
    t.integer  "formula_id"
    t.integer  "mixer_id"
    t.integer  "extruder_id"
    t.decimal  "resin_big_batch_quantity",   :precision => 11, :scale => 5
    t.decimal  "resin_small_batch_quantity", :precision => 11, :scale => 5
    t.decimal  "big_batch_quantity",         :precision => 11, :scale => 5
    t.decimal  "small_batch_quantity",       :precision => 11, :scale => 5
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lot_number"
  end

  create_table "mixers", :force => true do |t|
    t.string   "name"
    t.string   "brand"
    t.boolean  "active",     :default => true
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_material_transaction_items", :force => true do |t|
    t.string   "lot_number"
    t.decimal  "quantity",                    :precision => 11, :scale => 5
    t.integer  "raw_material_transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "raw_material_transactions", :force => true do |t|
    t.string   "transaction_type"
    t.string   "reference_type"
    t.string   "reference_number"
    t.date     "transaction_date"
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
    t.string   "issue_type"
    t.integer  "issued_to_id"
    t.string   "issued_to_type"
    t.string   "dr_number"
    t.string   "si_number"
  end

  create_table "raw_material_types", :force => true do |t|
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
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
    t.decimal  "critical_quantity",    :precision => 11, :scale => 5
    t.boolean  "trading_good",                                        :default => false
    t.boolean  "active",                                              :default => true
  end

  create_table "role_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "permissions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                             :default => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "applicable_to_rm",                   :default => true
    t.boolean  "applicable_to_fg",                   :default => true
    t.boolean  "applicable_to_supplies_oc",          :default => true
    t.boolean  "applicable_to_supplies_engineering", :default => true
    t.boolean  "applicable_to_supplies_packaging",   :default => true
    t.boolean  "applicable_to_supplies_scrap",       :default => true
  end

  create_table "supplies", :force => true do |t|
    t.string   "name"
    t.string   "supply_type"
    t.text     "description"
    t.text     "comments"
    t.integer  "unit_of_measure_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "active",             :default => true
  end

  create_table "supply_transaction_items", :force => true do |t|
    t.decimal  "quantity",              :precision => 11, :scale => 5
    t.decimal  "unit_price",            :precision => 11, :scale => 5
    t.integer  "supply_id"
    t.integer  "supply_transaction_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supply_transactions", :force => true do |t|
    t.string   "transaction_type"
    t.date     "transaction_date"
    t.integer  "supplier_id"
    t.string   "usage"
    t.string   "rr_number"
    t.string   "pre_number"
    t.string   "mirs_number"
    t.string   "lot_number"
    t.integer  "issued_department_id"
    t.integer  "issued_user_id"
    t.text     "comments"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "supply_type"
    t.string   "po_number"
    t.string   "reference_type"
    t.string   "misc_sales_number"
    t.string   "sr_number"
    t.integer  "issued_customer_id"
  end

  create_table "unit_of_measures", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "applicable_to_rm",                   :default => true
    t.boolean  "applicable_to_fg",                   :default => true
    t.boolean  "applicable_to_supplies_oc",          :default => true
    t.boolean  "applicable_to_supplies_engineering", :default => true
    t.boolean  "applicable_to_supplies_packaging",   :default => true
    t.boolean  "applicable_to_supplies_scrap",       :default => true
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

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username"

end
