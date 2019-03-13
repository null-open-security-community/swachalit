class CreateUserAuthProfiles < ActiveRecord::Migration
  def change
    create_table :user_auth_profiles do |t|
      t.integer :user_id
      t.binary :oauth_data
      t.binary :extra
      t.string :uid
      t.string :provider
      
      t.timestamps
    end
  end
end
