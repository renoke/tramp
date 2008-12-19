require File.dirname(__FILE__) + '/../../test_helper'

class CurrencyTest < ActiveSupport::TestCase
  
  test "should return digit from alphabetic symbol CHF" do
    assert_equal 2, Currency.decimal('CHF')
  end
  
  test "should return cents multiplier for CHF" do
    assert_equal 100, Currency.cents_multiplier('CHF')
  end
  
  test "should return cents multiplier for 756" do
    assert_equal 100, Currency.cents_multiplier(756)
  end
  
end