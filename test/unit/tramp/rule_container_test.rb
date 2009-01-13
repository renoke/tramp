require File.dirname(__FILE__) + '/../../test_helper'

class Tramp::RuleContainerTest < ActiveSupport::TestCase
  
  def setup
    super
    @rc = Tramp::RuleContainer.new
  end
  
  test "should add entry" do
    @rc.add_entry(:account=>'abc', :amount=>10)
    assert_equal [{:account=>'abc', :amount=>10}], @rc.entries
  end
  
  test "should add collection" do
    @rc.add_collection('some_collection')
    assert_equal ['some_collection'], @rc.collections
  end
  
  test "should add secondary event" do
    @rc.add_secondary_event('TaxEvent')
    assert_equal ['TaxEvent'], @rc.secondary_events
  end
  
  test "should add multiple secondary events" do
    @rc.add_secondary_event 'TaxEvent', 'SomeEvent'
    assert_equal ['TaxEvent', 'SomeEvent'], @rc.secondary_events
  end
end