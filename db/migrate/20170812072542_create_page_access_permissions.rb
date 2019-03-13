class CreatePageAccessPermissions < ActiveRecord::Migration
  def change
    create_table :page_access_permissions do |t|
      t.string  :permission_type
      t.integer :page_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
