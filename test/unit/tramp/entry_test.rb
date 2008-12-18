require File.dirname(__FILE__) + '/../../test_helper'


class EntryTest < ActiveSupport::TestCase

  def setup
    super
    @entry = Tramp::Model::Entry.new
    @entry.debit = Money.new(20)
  end
  
  test "should return solde with default orientation" do
    entry = Tramp::Model::Entry.new(:amount=> 20)
    assert_equal 20.0, entry.solde
  end
  
  test "should return solde with orientation D" do
    entry = Tramp::Model::Entry.create(:debit=> 20)
    assert_equal 20.0, entry.solde('D')
  end
  
  test "should find entries with account" do
    event = MockEvent.new
    event.create_entries
    assert_equal 1, Tramp::Model::Entry.find(:all, :conditions=>["account = ?",'abc']).size
  end
  
  test "should return debit attribute in cents" do
    assert_equal 2000, @entry.debit.to_cents
  end
  
  test "should return debit formatted to string" do
    assert_equal "20.00", @entry.debit.to_s 
  end
  
  test "should return debit formatted to float" do
    entry = Tramp::Model::Entry.create(:debit=>20)
    assert_equal 20.0, Tramp::Model::Entry.find(:last).debit.to_f
  end
  
  test "should save null debit" do
    @entry.debit = Money.empty
    assert_equal 0, @entry.debit.to_i
  end
  
  test "should use constructor with Numeric" do
    @entry.debit = 20
    @entry.credit= 20
    assert_equal 2000, @entry.debit.to_i
    assert_equal 2000, @entry.credit.to_i
  end
  
  test "should use constructor with Array and currency" do
    @entry.debit = [20, 'CHF']
    assert_equal 2000, @entry.debit.to_i
  end
  
  test "should use constructor with Array and withour currency" do
    @entry.debit = [20]
    assert_equal 2000, @entry.debit.to_i
  end 
  
  test "should use constructor with Hash" do
    @entry.debit = {:amount=>20, :currency=>'CHF'}
    assert_equal 2000, @entry.debit.to_i
  end
  
  test "should use constructor with String" do
    @entry.debit = '20'
    assert_equal 2000, @entry.debit.to_i
  end
  
  test "should change default currency" do
    Money.default_currency = 'CHF'
    @entry.debit = Money.new(20)
    assert_equal 'CHF', @entry.currency
  end
  
  def teardown
    MockEvent.delete(:all)
  end

end
