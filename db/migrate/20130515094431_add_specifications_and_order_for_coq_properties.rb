class AddSpecificationsAndOrderForCoqProperties < ActiveRecord::Migration
  def up
    add_column :coq_properties, :specifications, :string
    add_column :coq_properties, :order, :string
  end

  def down
    add_column :coq_properties, :specifications
    add_column :coq_properties, :order
  end
end
