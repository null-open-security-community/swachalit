class CreateSessionProposals < ActiveRecord::Migration
  def change
    create_table :session_proposals do |t|
      t.integer   :chapter_id
      t.integer   :user_id
      t.integer   :event_type_id
      t.string    :session_topic
      t.text      :session_description

      t.timestamps
    end
  end
end
