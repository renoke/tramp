require File.dirname(__FILE__) + '/../../test_helper'


class PostingRuleTest < ActiveSupport::TestCase

  def setup
    super
    @empty_rule = Tramp::Model::PostingRule.new
  end
  
  test "should eval empty rule" do
    assert_equal [], @empty_rule.eval
  end
  
  test "should show entries" do
    mock_rule = MockRule.new
    assert_equal [{:debit=>"event.foo", :account=>"abc"}, {:credit=>:foo, :account=>"def"}], mock_rule.entries
  end
  
  test "should eval movement rule" do
    event = MockEvent.new
    mock_rule = MockRule.new(:event=>event)
    assert_equal [{:debit=>20, :account=>"abc"}, {:credit=>20, :account=>"def"}], mock_rule.eval
  end
  
  test "should eval parameter" do
    param_rule = Tramp::Model::PostingRule.new
    param_rule.class_eval do
      parameter :foo, '100'
    end
    assert_equal 100, param_rule.foo
  end

end
