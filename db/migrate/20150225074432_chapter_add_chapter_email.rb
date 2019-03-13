class ChapterAddChapterEmail < ActiveRecord::Migration
  def up
    add_column :chapters, :chapter_email, :string
  end

  def down
    remove_column :chapters, :chapter_email
  end
end
