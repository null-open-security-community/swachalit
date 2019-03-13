class AddChapterSocial < ActiveRecord::Migration
  def up
    add_column    :chapters, :twitter_handle, :string
    add_column    :chapters, :facebook_profile, :string
    add_column    :chapters, :linkedin_profile, :string
    add_column    :chapters, :slideshare_profile, :string
    add_column    :chapters, :github_profile, :string
  end

  def down
  end
end
