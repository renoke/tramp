
  
  
  class MockRule < Tramp::Model::Rule
    parameter :foo,'event.foo'
    movement do |rule|
      rule.add_entry({:account => 'abc',:debit=>'event.foo'}, {:account=>'def',:credit=> :foo})
      rule.add_secondary_event('MockEventDate')
    end
  end

  class MockEvent < Tramp::Model::Event
    attr_accessor :foo
    rule :mock_rule
    def initialize
      @foo=20
      super
    end
  end
  
  class MockRuleDate < Tramp::Model::Rule
    movement do |rule|
      rule.add_entry(:date=>Date.today, :account=>'t1', :debit=>20)
      rule.add_entry(:date=>Date.today, :account=>'t2', :credit=>20)
    end
  end
  
  class MockEventDate < Tramp::Model::Event
    rule :mock_rule_date
  end
  
  class EventTwoRules < Tramp::Model::Event
    attr_accessor :foo
    rule :mock_rule
    rule :mock_rule_date
    def initialize
      @foo=20
      super
    end
  end
  
  
