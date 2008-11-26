require File.dirname(__FILE__) + '/../../test_helper'

class Tramp::MovementTest < ActiveSupport::TestCase
  
  def setup
    super
    @transaction = Tramp::Movement.new
  end
  
  test "should_not_be_balanced_if_empty_entries" do
    assert !@transaction.balanced?
  end
  
  test "should_not_be_balanced_if_debit_only" do
    @transaction.add_entry(Tramp::Entry.new(:debit=>10))
    assert !@transaction.balanced?
  end
  
  test "should raise an error if not balanced" do
    @transaction.save
    assert @transaction.errors[:entry]
  end
  
  test "should be balanced" do 
    @transaction.add_entry(Tramp::Entry.new(:debit=>10), Tramp::Entry.new(:credit=>10))
    assert @transaction.balanced?
  end
  
  test "should save entries" do
    @transaction.add_entry(Tramp::Entry.new(:debit=>10), Tramp::Entry.new(:credit=>10))
    assert @transaction.save_entries
    assert !@transaction.entries[0].new_record?  
  end
  
end
