class EditUser < ActiveRecord::Migration
  def up
    add_column :users, :homepage, :string
    add_column :users, :about_me, :string
  end

  def down
    remove_column :users, :homepage
    remove_column :users, :about_me
  end
end
