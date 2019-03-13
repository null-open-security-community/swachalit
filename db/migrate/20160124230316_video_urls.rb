class VideoUrls < ActiveRecord::Migration
  def up
    add_column :event_sessions, :video_url, :string  	
  end

  def down
  end
end
