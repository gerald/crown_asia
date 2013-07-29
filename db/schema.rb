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

ActiveRecord::Schema.define(:version => 20130729123756) do

  create_table "Batch", :id => false, :force => true do |t|
    t.string  "CtrlNo",    :limit => 10
    t.integer "FormulaID"
    t.integer "FromBatch"
    t.integer "ToBatch"
    t.integer "Batches"
    t.date    "BatchDate"
    t.string  "BatchType", :limit => 1
  end

  create_table "RM", :id => false, :force => true do |t|
    t.integer "RMID"
    t.integer "RMTypeID"
    t.string  "RMType",     :limit => 5
    t.string  "RMTypeDesc", :limit => 20
    t.string  "RMItem",     :limit => 20
    t.date    "CompDate"
  end

  create_table "Row1", :id => false, :force => true do |t|
    t.integer "Row1"
    t.string  "CtrlNo1",        :limit => 10
    t.string  "CtrlNo2",        :limit => 10
    t.string  "CtrlNo3",        :limit => 10
    t.string  "CtrlNo4",        :limit => 10
    t.string  "CtrlNo5",        :limit => 10
    t.string  "CtrlNo6",        :limit => 10
    t.string  "CtrlNo7",        :limit => 10
    t.string  "CtrlNo8",        :limit => 10
    t.string  "CtrlNo9",        :limit => 10
    t.string  "CtrlNo10",       :limit => 10
    t.string  "CtrlNo11",       :limit => 10
    t.string  "CtrlNo12",       :limit => 10
    t.string  "CtrlNo13",       :limit => 10
    t.string  "CtrlNo14",       :limit => 10
    t.string  "FG1",            :limit => 80
    t.string  "FG2",            :limit => 80
    t.string  "FG3",            :limit => 80
    t.string  "FG4",            :limit => 80
    t.string  "FG5",            :limit => 80
    t.string  "FG6",            :limit => 80
    t.string  "FG7",            :limit => 80
    t.string  "FG8",            :limit => 80
    t.string  "FG9",            :limit => 80
    t.string  "FG10",           :limit => 80
    t.string  "FG11",           :limit => 80
    t.string  "FG12",           :limit => 80
    t.string  "FG13",           :limit => 80
    t.string  "FG14",           :limit => 80
    t.string  "FGLoc1",         :limit => 12
    t.string  "FGLoc2",         :limit => 12
    t.string  "FGLoc3",         :limit => 12
    t.string  "FGLoc4",         :limit => 12
    t.string  "FGLoc5",         :limit => 12
    t.string  "FGLoc6",         :limit => 12
    t.string  "FGLoc7",         :limit => 12
    t.string  "FGLoc8",         :limit => 12
    t.string  "FGLoc9",         :limit => 12
    t.string  "FGLoc10",        :limit => 12
    t.string  "FGLoc11",        :limit => 12
    t.string  "FGLoc12",        :limit => 12
    t.string  "FGLoc13",        :limit => 12
    t.string  "FGLoc14",        :limit => 12
    t.integer "FromBatch1"
    t.integer "FromBatch2"
    t.integer "FromBatch3"
    t.integer "FromBatch4"
    t.integer "FromBatch5"
    t.integer "FromBatch6"
    t.integer "FromBatch7"
    t.integer "FromBatch8"
    t.integer "FromBatch9"
    t.integer "FromBatch10"
    t.integer "FromBatch11"
    t.integer "FromBatch12"
    t.integer "FromBatch13"
    t.integer "FromBatch14"
    t.integer "ToBatch1"
    t.integer "ToBatch2"
    t.integer "ToBatch3"
    t.integer "ToBatch4"
    t.integer "ToBatch5"
    t.integer "ToBatch6"
    t.integer "ToBatch7"
    t.integer "ToBatch8"
    t.integer "ToBatch9"
    t.integer "ToBatch10"
    t.integer "ToBatch11"
    t.integer "ToBatch12"
    t.integer "ToBatch13"
    t.integer "ToBatch14"
    t.integer "OrigBatchQty1"
    t.integer "OrigBatchQty2"
    t.integer "OrigBatchQty3"
    t.integer "OrigBatchQty4"
    t.integer "OrigBatchQty5"
    t.integer "OrigBatchQty6"
    t.integer "OrigBatchQty7"
    t.integer "OrigBatchQty8"
    t.integer "OrigBatchQty9"
    t.integer "OrigBatchQty10"
    t.integer "OrigBatchQty11"
    t.integer "OrigBatchQty12"
    t.integer "OrigBatchQty13"
    t.integer "OrigBatchQty14"
  end

  create_table "TEMP_P003", :id => false, :force => true do |t|
    t.integer "RowNumNew"
    t.integer "RowNo"
    t.string  "CtrlNo",       :limit => 10
    t.integer "FormulaID"
    t.integer "FromBatch"
    t.integer "ToBatch"
    t.integer "Batches"
    t.string  "FGLocalBatch", :limit => 12
    t.string  "FGItem",       :limit => 100
    t.decimal "OrigBatchQty",                :precision => 10, :scale => 0
    t.string  "Mixer",        :limit => 5
    t.string  "Extruder",     :limit => 5
    t.integer "IssuedRMID"
    t.decimal "BatchSize",                   :precision => 12, :scale => 5
  end

  create_table "X001", :id => false, :force => true do |t|
    t.integer "FGID"
    t.string  "FGItem",        :limit => 50
    t.integer "FGLocal"
    t.integer "RMID"
    t.string  "RMCode",        :limit => 10
    t.string  "RMName",        :limit => 50
    t.decimal "Quantity",                    :precision => 25, :scale => 5
    t.integer "CostingPeriod"
    t.decimal "ManufCost",                   :precision => 10, :scale => 4
    t.decimal "Forex",                       :precision => 10, :scale => 4
    t.decimal "RMUnitCost",                  :precision => 10, :scale => 4
    t.decimal "BatchSize",                   :precision => 25, :scale => 5
    t.decimal "RMOrigCost",                  :precision => 25, :scale => 5
    t.decimal "RMCost",                      :precision => 25, :scale => 5
  end

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

