class AddApplicableToForSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :applicable_to_rm, :boolean, :default => true
    add_column :suppliers, :applicable_to_fg, :boolean, :default => true
    add_column :suppliers, :applicable_to_supplies_oc, :boolean, :default => true
    add_column :suppliers, :applicable_to_supplies_engineering, :boolean, :default => true
    add_column :suppliers, :applicable_to_supplies_packaging, :boolean, :default => true
    add_column :suppliers, :applicable_to_supplies_scrap, :boolean, :default => true
  end
end
