require File.dirname(__FILE__) + '/../../test_helper'


class ServiceAgreementTest < ActiveSupport::TestCase
  
  def setup
    super
    @sa = Tramp::ServiceAgreement.new
  end
  
  test "should belongs to event type" do
    assert @sa.event_type = Tramp::EventType.new
  end
  
  test "should belongs to posting rule" do
    assert @sa.posting_rule = MockRule.new
  end
  
  test "should has and belongs to paries" do
    assert @sa.parties << Tramp::Party.new
  end
   
end
