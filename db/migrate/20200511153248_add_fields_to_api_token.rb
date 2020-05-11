class AddFieldsToApiToken < ActiveRecord::Migration
  def change
    add_column :user_api_tokens, :active, :boolean, default: false
    add_column :user_api_tokens, :expire_at, :datetime

    add_index :user_api_tokens, :active
    add_index :user_api_tokens, :expire_at
    add_index :user_api_tokens, :token
  end
end
