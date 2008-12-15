require File.dirname(__FILE__) + '/../../test_helper'

class Tramp::AccountTest < ActiveSupport::TestCase
  

  def setup
    super
    @account = Tramp::Model::Account.new(:code => 't1', :orientation=>'D')
    @event = MockEventDate.new
    @event.create_entries
  end

  test "should return entries" do
    assert_equal 1, @account.entries.size
  end


  test "should give balance" do
    assert_equal 20, @account.balance
  end

  test "should give deposit" do
    assert_equal 20, @account.deposits
  end

  test "should return withdrawls" do
    assert_equal 0, @account.withdrawls
  end
  
end
