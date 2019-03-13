class CreateUserAchievements < ActiveRecord::Migration
  def change
    create_table :user_achievements do |t|
      t.references :user
      t.string :source
      t.string :achievement_type
      t.string :info
      t.string :reference

      t.timestamps
    end
  end
end
