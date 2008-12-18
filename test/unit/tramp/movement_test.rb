require File.dirname(__FILE__) + '/../../test_helper'

class Tramp::MovementTest < ActiveSupport::TestCase
  
  def setup
    super
    @transaction = Tramp::Model::Movement.new
  end
  
  test "shoul_add_entries" do
    @transaction.add_entries({:debit=>30},{:credit=>30})
    assert_equal 3000, @transaction.entries.first.debit.to_i
    assert_equal 30.0, @transaction.entries.first.debit.to_f
  end
  
  test "should_not_be_balanced_if_empty_entries" do
    assert !@transaction.balanced?
  end
  
  test "should_not_be_balanced_if_debit_only" do
    @transaction.add_entry(Tramp::Model::Entry.new(:debit=>10))
    assert !@transaction.balanced?
  end
  
  test "should raise an error if not balanced" do
    @transaction.save
    assert @transaction.errors[:entry]
  end
  
  test "should be balanced" do 
    @transaction.add_entry(Tramp::Model::Entry.new(:debit=>10), Tramp::Model::Entry.new(:credit=>10))
    assert @transaction.balanced?
  end
  
  test "should save entries" do
    @transaction.add_entry(Tramp::Model::Entry.new(:debit=>10), Tramp::Model::Entry.new(:credit=>10))
    assert @transaction.save_entries
    assert !@transaction.entries[0].new_record?  
  end
  
end
