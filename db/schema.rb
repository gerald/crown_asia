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

ActiveRecord::Schema.define(:version => 20130125102138) do

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

  add_index "bags", ["finished_good_id"], :name => "index_bags_on_finished_good_id"
  add_index "bags", ["finished_good_transaction_item_id"], :name => "index_bags_on_finished_good_transaction_item_id"
  add_index "bags", ["lot_number"], :name => "index_bags_on_lot_number"
  add_index "bags", ["removing_transaction_id"], :name => "index_bags_on_removing_transaction_id"

  create_table "calendar", :primary_key => "calID", :force => true do |t|
    t.date    "calDate"
    t.integer "calYear"
    t.integer "calMonth"
    t.string  "calMonthShort", :limit => 3
    t.string  "calMonthLong",  :limit => 15
  end

  add_index "calendar", ["calDate"], :name => "days", :unique => true

  create_table "coq_properties", :force => true do |t|
    t.string   "name"
    t.string   "test_method"
    t.boolean  "soft",        :default => false
    t.boolean  "rigid",       :default => false
    t.integer  "position"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "costing_period_items", :force => true do |t|
    t.integer  "raw_material_id"
    t.integer  "costing_period_id"
    t.decimal  "quote",             :precision => 11, :scale => 2
    t.decimal  "fg",                :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costing_period_items", ["costing_period_id"], :name => "index_costing_period_items_on_costing_period_id"
  add_index "costing_period_items", ["raw_material_id"], :name => "index_costing_period_items_on_raw_material_id"

  create_table "costing_periods", :force => true do |t|
    t.date     "costing_date"
    t.decimal  "manufacturing_quote", :precision => 11, :scale => 2
    t.decimal  "manufacturing_fg",    :precision => 11, :scale => 2
    t.decimal  "forex_quote",         :precision => 11, :scale => 2
    t.decimal  "forex_fg",            :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
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

  add_index "finished_good_transaction_items", ["finished_good_transaction_id"], :name => "fg_transaction_index"
  add_index "finished_good_transaction_items", ["lot_number"], :name => "index_finished_good_transaction_items_on_lot_number"

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

  add_index "finished_good_transactions", ["finished_good_id"], :name => "index_finished_good_transactions_on_finished_good_id"
  add_index "finished_good_transactions", ["issued_to_id", "issued_to_type"], :name => "issued_to_index"
  add_index "finished_good_transactions", ["sender_id", "sender_type"], :name => "sender_index"

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
    t.boolean  "sales_quote",        :default => false
    t.boolean  "soft_pvc",           :default => false
  end

  add_index "finished_goods", ["customer_id"], :name => "index_finished_goods_on_customer_id"
  add_index "finished_goods", ["unit_of_measure_id"], :name => "index_finished_goods_on_unit_of_measure_id"

  create_table "formula_items", :force => true do |t|
    t.decimal  "quantity",             :precision => 11, :scale => 5
    t.decimal  "multiplier",           :precision => 11, :scale => 8
    t.integer  "formula_id"
    t.integer  "raw_material_type_id"
    t.integer  "raw_material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formula_items", ["formula_id"], :name => "index_formula_items_on_formula_id"
  add_index "formula_items", ["raw_material_id"], :name => "index_formula_items_on_raw_material_id"
  add_index "formula_items", ["raw_material_type_id"], :name => "index_formula_items_on_raw_material_type_id"

  create_table "formulas", :force => true do |t|
    t.string   "formula_type"
    t.boolean  "finished_good_local", :default => true
    t.integer  "finished_good_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comments"
  end

  add_index "formulas", ["finished_good_id"], :name => "index_formulas_on_finished_good_id"

  create_table "issued_formula_batches", :force => true do |t|
    t.integer  "start_batch"
    t.integer  "end_batch"
    t.date     "batch_date"
    t.integer  "issued_formula_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_small_batch"
    t.integer  "end_small_batch"
    t.date     "small_batch_date"
    t.boolean  "processed",         :default => false
  end

  add_index "issued_formula_batches", ["issued_formula_id"], :name => "index_issued_formula_batches_on_issued_formula_id"

  create_table "issued_formula_items", :force => true do |t|
    t.integer  "issued_formula_id"
    t.integer  "raw_material_id"
    t.decimal  "big_batch_quantity",   :precision => 11, :scale => 5
    t.decimal  "small_batch_quantity", :precision => 11, :scale => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issued_formula_items", ["issued_formula_id"], :name => "index_issued_formula_items_on_issued_formula_id"
  add_index "issued_formula_items", ["raw_material_id"], :name => "index_issued_formula_items_on_raw_material_id"

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
    t.date     "production_date"
    t.text     "comments"
    t.boolean  "canceled_big_batch",                                        :default => false
    t.boolean  "canceled_small_batch",                                      :default => false
  end

  add_index "issued_formulas", ["extruder_id"], :name => "index_issued_formulas_on_extruder_id"
  add_index "issued_formulas", ["finished_good_id"], :name => "index_issued_formulas_on_finished_good_id"
  add_index "issued_formulas", ["formula_id"], :name => "index_issued_formulas_on_formula_id"
  add_index "issued_formulas", ["lot_number"], :name => "index_issued_formulas_on_lot_number"
  add_index "issued_formulas", ["mixer_id"], :name => "index_issued_formulas_on_mixer_id"

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

  add_index "raw_material_transaction_items", ["lot_number"], :name => "index_raw_material_transaction_items_on_lot_number"
  add_index "raw_material_transaction_items", ["raw_material_transaction_id"], :name => "rm_transaction_index"

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

  add_index "raw_material_transactions", ["issued_department_id"], :name => "index_raw_material_transactions_on_issued_department_id"
  add_index "raw_material_transactions", ["issued_to_id", "issued_to_type"], :name => "issued_to_index"
  add_index "raw_material_transactions", ["raw_material_id"], :name => "index_raw_material_transactions_on_raw_material_id"
  add_index "raw_material_transactions", ["sender_id", "sender_type"], :name => "sender_index"

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
    t.boolean  "costing",                                             :default => false
  end

  add_index "raw_materials", ["raw_material_type_id"], :name => "index_raw_materials_on_raw_material_type_id"
  add_index "raw_materials", ["supplier_id"], :name => "index_raw_materials_on_supplier_id"
  add_index "raw_materials", ["unit_of_measure_id"], :name => "index_raw_materials_on_unit_of_measure_id"

  create_table "role_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_users", ["role_id"], :name => "index_role_users_on_role_id"
  add_index "role_users", ["user_id"], :name => "index_role_users_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "permissions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "sales_quote_items", :force => true do |t|
    t.integer  "finished_good_id"
    t.integer  "sales_quote_id"
    t.decimal  "quote",            :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales_quotes", :force => true do |t|
    t.date     "quote_date"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  add_index "supplies", ["unit_of_measure_id"], :name => "index_supplies_on_unit_of_measure_id"

  create_table "supply_transaction_items", :force => true do |t|
    t.decimal  "quantity",              :precision => 11, :scale => 5
    t.decimal  "unit_price",            :precision => 11, :scale => 5
    t.integer  "supply_id"
    t.integer  "supply_transaction_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supply_transaction_items", ["supply_id"], :name => "index_supply_transaction_items_on_supply_id"
  add_index "supply_transaction_items", ["supply_transaction_id"], :name => "index_supply_transaction_items_on_supply_transaction_id"

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

  add_index "supply_transactions", ["issued_customer_id"], :name => "index_supply_transactions_on_issued_customer_id"
  add_index "supply_transactions", ["issued_department_id"], :name => "index_supply_transactions_on_issued_department_id"
  add_index "supply_transactions", ["issued_user_id"], :name => "index_supply_transactions_on_issued_user_id"
  add_index "supply_transactions", ["lot_number"], :name => "index_supply_transactions_on_lot_number"
  add_index "supply_transactions", ["supplier_id"], :name => "index_supply_transactions_on_supplier_id"

  create_table "temp", :id => false, :force => true do |t|
    t.integer "id", :null => false
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
