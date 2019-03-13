class AddIndexChapterLeads < ActiveRecord::Migration
  def change
    add_index :chapter_leads, :chapter_id
    add_index :chapter_leads, :user_id
  end
end
