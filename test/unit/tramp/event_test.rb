require File.dirname(__FILE__) + '/../../test_helper'


class Tramp::EventTest < ActiveSupport::TestCase
  
  def setup
    super
    @event = Tramp::Event.new
  end
  
  test "should return empty rule" do
    assert_kind_of Tramp::PostingRule, @event.rule
  end
  
  test "should eval empty rule" do
    assert_equal [], @event.rule.eval
    assert @event.rule.eval.empty?
  end
  
  test "should find rule" do
    event = MockEvent.new
    assert_kind_of MockRule, event.rule
  end
  
  test "should eval rule" do
    event = MockEvent.new
    assert_equal [{:debit=>20, :account=>"abc"}, {:credit=>20, :account=>"def"}], event.rule.eval
  end
  
  test "should create movement with hash" do
    assert container =  @event.create_movement({:debit=>10},{:credit=>10})
    assert_kind_of Tramp::Entry, container.entries[0]
    assert !container.new_record?
    assert @event.entries
  end
  
  test "should make new movement with Hash" do
    assert container = @event.new_movement({:debit=>10},{:credit=>10})
    assert_kind_of Tramp::Entry, container.entries[0]
    assert container.new_record?
    assert_equal [], @event.entries
  end
  
  test "should create movement with rule" do
    mock_event = MockEvent.new
    container = mock_event.create_movement
    assert_equal 20, mock_event.entries[0].debit
  end
  
  test "should make new movement with rule" do
    mock_event = MockEvent.new
    container = mock_event.new_movement
    assert_equal 20, container.entries[0].debit
  end
  
  test "should destroy movement" do
    mock_event = MockEvent.new
    mock_event.create_movement
    assert mock_event.delete_movement
    assert_nil mock_event.movement
  end
  
  test "should update movement" do
    mock_event = MockEvent.new
    mock_event.create_movement
    mock_event.foo = 40
    assert mock_event.update_movement
    assert_equal 40, mock_event.entries[0].debit
  end
  
  def teardown
    MockEvent.delete(:all)
  end
  
end
