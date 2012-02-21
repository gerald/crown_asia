class UpdateUsersIndex < ActiveRecord::Migration
  def up
    remove_index :users, :email
    add_index :users, :username
  end

  def down
    add_index :users, :email
    remove_index :users, :username
  end
end
