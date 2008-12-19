require File.dirname(__FILE__) + '/../../test_helper'

class MoneyTest < ActiveSupport::TestCase
  
  test "should convert cents to fractional amount" do
    m = Money.new(10)
    assert_equal 1000, m.to_cents
  end
  
  test "should convert with Numeric" do
    assert_equal 2000, Money.convert(20).to_cents
  end
  
  test "should convert with String" do
    assert_equal 2000, Money.convert('20.0').to_cents
  end
  
  test "should convert with Array and no currency" do
    assert_equal 2000, Money.convert([20]).to_cents
  end
  
  test "should convert with Array and with currency" do
    assert_equal 2000, Money.convert([20, 'CHF']).to_cents
    assert_equal 'CHF', Money.convert([20, 'CHF']).currency
  end
  
  test "should convert with Array and with hash" do
    assert_equal 2000, Money.convert(:amount=>20, :currency=>'CHF').to_cents
    assert_equal 'CHF', Money.convert(:amount=>20, :currency=>'CHF').currency
  end
  
  test "should construct with cent" do
    assert_equal 2000, Money.construct(2000).to_cents
  end
  
end