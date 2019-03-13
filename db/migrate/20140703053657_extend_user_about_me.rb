class ExtendUserAboutMe < ActiveRecord::Migration
  def up
    change_column :users, :about_me, :text
  end

  def down
    change_column :users, :about_me, :string
  end
end
