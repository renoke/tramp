require File.dirname(__FILE__) + '/../../test_helper'


class Tramp::EventTypeTest < ActiveSupport::TestCase
  
  def setup
    super
    @event_type = Tramp::EventType.new(:code=>'test')
  end
  
  test "should have many events" do
    assert @event_type.events << MockEvent.new
  end
  
  test "should have many service agreements" do
    assert @event_type.service_agreements << Tramp::ServiceAgreement.new
  end
  
end
