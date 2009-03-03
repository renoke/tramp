require File.dirname(__FILE__) + '/../../test_helper'


class Tramp::Model::EventTest < ActiveSupport::TestCase
  
  def setup
    super
    @event = Tramp::Model::Event.new
  end
  
  test "should return  Tramp::Model::Rule if no rule specified" do
    assert_kind_of Tramp::Model::Rule, @event.rules.first
  end
  
  test "should find rules and return an array " do
    event = MockEvent.new
    assert_kind_of Array, event.rules
    assert_kind_of MockRule, event.rules.first
  end
  
  test "should create entries with hash and return true" do
    event =  Tramp::Model::Event.new
    assert event.create_entries({:debit=>10},{:credit=>10})
    assert_kind_of Tramp::Model::Entry, event.entries[0]
    assert !event.movement.new_record?
    assert_equal 1000, event.entries.first.debit.to_i
  end
  
  test "execution set should return an array, each set from a rule" do
    mock_event = MockEvent.new
    assert_kind_of Array, mock_event.execution_set
  end
  
  test "should create movement and return true" do
    mock_event = MockEvent.new
    assert_equal true, mock_event.create_entries
  end
  
  test "should make new movement with rule and return movement" do
    mock_event = MockEvent.new
    assert_kind_of Tramp::Model::Movement, mock_event.new_entries
  end
  
  test "should destroy movement" do
    mock_event = MockEvent.new
    mock_event.create_entries
    assert mock_event.delete_entries
    assert_nil mock_event.movement
  end
  
  test "should update movement and return true" do
    mock_event = MockEvent.new
    mock_event.create_entries
    mock_event.foo1 = 40
    assert_equal true, mock_event.update_entries
  end
  
  test "should rescue to Tramp::Model::Rule if bad rule specified" do
    class TryEvent < Tramp::Model::Event; end
    assert_kind_of Tramp::Model::Rule, TryEvent.rule(:Toto).new
  end
  
  test "should able to have two rules or more" do
    assert_equal 2, EventTwoRules.new.rules.size
  end
  
  test "should associate secondary events" do
    event = Tramp::Model::Event.new
    event.secondary_events << Tramp::Model::Event.new
    assert_equal 1, event.secondary_events.size
  end
  
  test "should return an array of secondary events in execution_set" do
    event = MockEvent.new
    assert_kind_of Array, event.execution_set.first[:secondary_events]
  end
  
  test "should return an event from the array of execution set" do
    event = MockEvent.new
    assert_kind_of Tramp::Model::Event, event.execution_set.first[:secondary_events].first
  end
  
  test "should create entries for secondary events and return an array of event for each set" do
    event = MockEvent.new
    assert_kind_of Tramp::Model::Event, event.secondary_event_factory.first.first
  end
  # 
  # test "should create entries if collection name is given" do
  #   event = MockEvent.new
  #   rule = MockRule.new(:event=> event)
  #   assert event.create_entries
  # end
  
  def teardown
    Tramp::Model::Event.delete(:all)
    Tramp::Model::Entry.delete(:all)    
  end
  
end
