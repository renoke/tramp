require File.dirname(__FILE__) + '/../../test_helper'

class Tramp::PartyTest < ActiveSupport::TestCase

  
  def setup
    super
    @party = Tramp::Party.new(:name => 'test')
  end
  
  
  test "should have many events" do
    assert @party.events << MockEvent.new
  end
  
  test "should have many service agreement" do
    assert @party.service_agreements << Tramp::ServiceAgreement.new
  end

  
end

  