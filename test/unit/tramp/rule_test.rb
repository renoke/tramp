require File.dirname(__FILE__) + '/../../test_helper'


class RuleTest < ActiveSupport::TestCase

  def setup
    super
    @empty_rule = Tramp::Model::Rule.new
  end
  
  test "should eval empty rule" do
    assert_equal Hash.new, @empty_rule.eval
  end
  
  test "should show entries" do
    mock_rule = MockRule.new
    assert_equal [{:debit=>"event.foo", :account=>"abc"}, {:credit=>:foo, :account=>"def"}], mock_rule.entries
  end
  
  test "should eval movement rule" do
    event = MockEvent.new
    mock_rule = MockRule.new(:event=>event)
    assert_equal [{:debit=>20, :account=>"abc"}, {:credit=>20, :account=>"def"}], mock_rule.eval[:entries]
  end
  
  test "should eval parameter" do
    param_rule = Tramp::Model::Rule.new
    param_rule.class_eval do
      parameter :foo, '100'
    end
    assert_equal 100, param_rule.foo
  end
  
  test "should eval rule with amount" do
    mock_rule = MockRuleDate.new
    assert_equal [{:date=>Date.today, :account=>'t1', :debit=>20}, {:date=>Date.today, :account=>'t2', :credit=>20}], 
                  mock_rule.eval[:entries]
  end
  
  test "should return secondary event" do
    rule = MockRule.new
    assert_equal ['MockEventDate'], rule.secondary_events
  end
  
  test "should eval secondary event" do
    rule = MockRule.new
    assert_kind_of MockEventDate, rule.eval_secondary_events.first
  end
  
  

end
