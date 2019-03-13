class CreateUserApiTokens < ActiveRecord::Migration
  def change
    create_table :user_api_tokens do |t|
      t.integer :user_id
      t.string  :user_agent
      t.string  :client_name
      t.string  :ip_address
      t.string  :token
      
      t.timestamps
    end
  end
end
