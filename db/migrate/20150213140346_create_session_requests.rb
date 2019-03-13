class CreateSessionRequests < ActiveRecord::Migration
  def change
    create_table :session_requests do |t|
      t.integer :chapter_id
      t.integer :user_id
      t.string  :session_topic
      t.text    :session_description
      
      t.timestamps
    end
  end
end
