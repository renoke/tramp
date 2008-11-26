require File.dirname(__FILE__) + '/../../test_helper'


class EntryTest < ActiveSupport::TestCase

  def setup
    super
    @event = MockEvent.new
    @event.create_movement
  end
  
  test "should find entries with account" do
    assert_equal 1, Tramp::Entry.find(:all, :conditions=>["account = ?",'abc']).size
  end
  
  def teardown
    MockEvent.delete(:all)
  end

end
