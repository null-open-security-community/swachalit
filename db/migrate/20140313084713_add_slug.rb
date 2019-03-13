class AddSlug < ActiveRecord::Migration
  def up
    add_column :events, :slug, :string
    add_column :event_sessions, :slug, :string

    add_index :events, :slug
    add_index :event_sessions, :slug
  end

  def down
    remove_column :events, :slug
    remove_column :event_sessions, :slug
  end
end
