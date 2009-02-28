require File.dirname(__FILE__) + '/../../test_helper'

class Tramp::RuleContainerTest < ActiveSupport::TestCase
  
  def setup
    super
    @rc = Tramp::RuleContainer.new
  end
  
  test "should add collection" do
    @rc.collections<<('some_collection')
    assert_equal ['some_collection'], @rc.collections
  end
  
  test "should add secondary event" do
    @rc.secondary_events<<('TaxEvent')
    assert_equal ['TaxEvent'], @rc.secondary_events
  end
  
  test "should add multiple secondary events with concat" do
    @rc.secondary_events.concat(['TaxEvent', 'SomeEvent'])
    assert_equal ['TaxEvent', 'SomeEvent'], @rc.secondary_events
  end
  
  test "should add entry with <<" do
    @rc.entries << {:account=>'abc', :amount=>10}
    assert_equal [{:account=>'abc', :amount=>10}], @rc.entries
  end
  
end