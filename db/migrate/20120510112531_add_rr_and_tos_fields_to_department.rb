class AddRrAndTosFieldsToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :rm_rr, :boolean, :default => true
    add_column :departments, :fg_tos, :boolean, :default => true
  end
end
