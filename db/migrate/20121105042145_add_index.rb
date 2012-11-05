class AddIndex < ActiveRecord::Migration
  def up
    add_index :bags, :removing_transaction_id
    add_index :bags, :finished_good_id
    add_index :bags, :finished_good_transaction_item_id
    add_index :bags, :lot_number
    add_index :costing_period_items, :raw_material_id
    add_index :costing_period_items, :costing_period_id
    add_index :finished_good_transaction_items, :lot_number
    add_index :finished_good_transaction_items, :finished_good_transaction_id, :name => "fg_transaction_index"
    add_index :finished_good_transactions, :finished_good_id
    add_index :finished_good_transactions, [:sender_id, :sender_type], :name => "sender_index"
    add_index :finished_good_transactions, [:issued_to_id, :issued_to_type], :name => "issued_to_index"
    add_index :finished_goods, :unit_of_measure_id
    add_index :finished_goods, :customer_id
    add_index :formula_items, :formula_id
    add_index :formula_items, :raw_material_type_id
    add_index :formula_items, :raw_material_id
    add_index :formulas, :finished_good_id
    add_index :issued_formula_batches, :issued_formula_id
    add_index :issued_formula_items, :issued_formula_id
    add_index :issued_formula_items, :raw_material_id
    add_index :issued_formulas, :finished_good_id
    add_index :issued_formulas, :formula_id
    add_index :issued_formulas, :mixer_id
    add_index :issued_formulas, :extruder_id
    add_index :issued_formulas, :lot_number
    add_index :raw_material_transaction_items, :lot_number
    add_index :raw_material_transaction_items, :raw_material_transaction_id, :name => "rm_transaction_index"
    add_index :raw_material_transactions, :raw_material_id
    add_index :raw_material_transactions, :issued_department_id
    add_index :raw_material_transactions, [:sender_id, :sender_type], :name => "sender_index"
    add_index :raw_material_transactions, [:issued_to_id, :issued_to_type], :name => "issued_to_index"
    add_index :raw_materials, :raw_material_type_id
    add_index :raw_materials, :unit_of_measure_id
    add_index :raw_materials, :supplier_id
    add_index :role_users, :role_id
    add_index :role_users, :user_id
    add_index :supplies, :unit_of_measure_id
    add_index :supply_transaction_items, :supply_id
    add_index :supply_transaction_items, :supply_transaction_id
    add_index :supply_transactions, :supplier_id
    add_index :supply_transactions, :lot_number
    add_index :supply_transactions, :issued_department_id
    add_index :supply_transactions, :issued_user_id
    add_index :supply_transactions, :issued_customer_id
  end

  def down
    remove_index :bags, :removing_transaction_id
    remove_index :bags, :finished_good_id
    remove_index :bags, :finished_good_transaction_item_id
    remove_index :bags, :lot_number
    remove_index :costing_period_items, :raw_material_id
    remove_index :costing_period_items, :costing_period_id
    remove_index :finished_good_transaction_items, :lot_number
    remove_index :finished_good_transaction_items, :name => "fg_transaction_index"
    remove_index :finished_good_transactions, :finished_good_id
    remove_index :finished_good_transactions, :name => "sender_index"
    remove_index :finished_good_transactions, :name => "issued_to_index"
    remove_index :finished_goods, :unit_of_measure_id
    remove_index :finished_goods, :customer_id
    remove_index :formula_items, :formula_id
    remove_index :formula_items, :raw_material_type_id
    remove_index :formula_items, :raw_material_id
    remove_index :formulas, :finished_good_id
    remove_index :issued_formula_batches, :issued_formula_id
    remove_index :issued_formula_items, :issued_formula_id
    remove_index :issued_formula_items, :raw_material_id
    remove_index :issued_formulas, :finished_good_id
    remove_index :issued_formulas, :formula_id
    remove_index :issued_formulas, :mixer_id
    remove_index :issued_formulas, :extruder_id
    remove_index :issued_formulas, :lot_number
    remove_index :raw_material_transaction_items, :lot_number
    remove_index :raw_material_transaction_items, :name => "rm_transaction_index"
    remove_index :raw_material_transactions, :raw_material_id
    remove_index :raw_material_transactions, :issued_department_id
    remove_index :raw_material_transactions, :name => "sender_index"
    remove_index :raw_material_transactions, :name => "issued_to_index"
    remove_index :raw_materials, :raw_material_type_id
    remove_index :raw_materials, :unit_of_measure_id
    remove_index :raw_materials, :supplier_id
    remove_index :role_users, :role_id
    remove_index :role_users, :user_id
    remove_index :supplies, :unit_of_measure_id
    remove_index :supply_transaction_items, :supply_id
    remove_index :supply_transaction_items, :supply_transaction_id
    remove_index :supply_transactions, :supplier_id
    remove_index :supply_transactions, :lot_number
    remove_index :supply_transactions, :issued_department_id
    remove_index :supply_transactions, :issued_user_id
    remove_index :supply_transactions, :issued_customer_id
  end
end
