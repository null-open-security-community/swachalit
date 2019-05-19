require 'test_helper'

class ChapterTest < ActiveSupport::TestCase
  test "basic validations" do
    c = ::Chapter.new
    assert !c.save

    c.name = "TEST"
    c.description = "TEST"

    assert c.save

    c = ::Chapter.new
    c.name = "TEST"
    c.description = "New Desc"
    assert !c.save
  end
end
