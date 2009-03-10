require File.dirname(__FILE__) + '/../../test_helper'


class RuleTest < ActiveSupport::TestCase

  def setup
    super
    @empty_rule = Tramp::Model::Rule.new
    @mock_event = MockEvent.new
  end
  
  test "should return container for empty rule" do
    assert_not_nil Tramp::Model::Rule.new.container
  end
  
  test "should eval entries" do
    mock_rule = MockRule.new(:event=>@mock_event)
    assert_equal [{:debit=>150, :account=>"abc"}, {:credit=>150, :account=>"defco"}], mock_rule.eval['entries']
  end
  
  test "should define multiple parameter" do
    rule = MockRule.new(:event => @mock_event)
    rule.eval
    assert rule.event.respond_to?(:bar1)
  end
  
  test "should eval rule with amount" do
    mock_rule = MockRuleDate.new
    assert_equal [{:date=>Date.today, :account=>'t1', :debit=>20}, {:date=>Date.today, :account=>'t2', :credit=>20}], 
                  mock_rule.eval['entries']
  end
  
  test "secondary_events should an array of string event name" do
    rule = MockRule.new
    assert_equal ['MockEventDate'], rule.container.secondary_events
  end
  
  test "eval_secondary_events should return an array of event class name" do
    rule = MockRule.new(:event => @mock_event)
    assert_kind_of MockEventDate, rule.eval['secondary_events'].first
  end
  
  test "eval with collection should return an array of collection name " do
    rule = MockRule.new(:event=>@mock_event)
    assert_equal [[{:debit=>100, :account=>"post_debit"},{:account=>"post_credit", :credit=>100}]], rule.eval['collections']
  end
  
  test "should read container" do
    rule = MockRule.new(:event=> @mock_event)
    assert_not_nil rule.container
  end

end
