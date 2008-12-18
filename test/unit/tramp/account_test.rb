require File.dirname(__FILE__) + '/../../test_helper'

class Tramp::AccountTest < ActiveSupport::TestCase
  

  def setup
    super
    @account = Tramp::Model::Account.new(:code => 't2', :orientation=>'D')
    Tramp::Model::Entry.create(:account=>'t2', :debit=>20, :date=>Date.today)
  end

  test "should return entries" do
    assert_kind_of Tramp::Model::Entry, @account.entries.first
  end
  
  test "should return Money for debit" do
    assert_kind_of Money, @account.entries.first.debit
  end

  test "should give balance" do
    assert_equal 20.0, @account.balance
  end

  test "should give deposit" do
    assert_equal 20.0, @account.deposits
  end

  test "should return withdrawls" do
    assert_equal 0, @account.withdrawls
  end
  
end
