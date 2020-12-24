class CreateEventSessionComments < ActiveRecord::Migration
  def change
    create_table :event_session_comments do |t|
      t.references :event_session
      t.references :user
      t.text :comment_body

	    t.timestamps
    end
  end
end
