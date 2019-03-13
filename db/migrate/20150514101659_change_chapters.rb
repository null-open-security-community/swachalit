class ChangeChapters < ActiveRecord::Migration
  def up
    change_column :chapters, :description, :longtext
    add_column    :chapters, :image, :string
  end

  def down
    change_column :chapters, :description, :string
  end
end
