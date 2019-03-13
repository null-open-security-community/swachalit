require 'test_helper'

class ChapterLeadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "validation" do
    c1 = ChapterLead.new({:chapter_id => 10, :user_id => 10, :active => true})
    assert c1.save

    c2 = ChapterLead.new({:chapter_id => 10, :user_id => 10, :active => true})
    assert !c2.save
  end
end
