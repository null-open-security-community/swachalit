class MaxRegistration < ActiveRecord::Migration
  def up
  	add_column    :events, :max_registration, :integer
  end

  def down
  end
end
