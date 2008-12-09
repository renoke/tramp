  
  class MockRule < Tramp::PostingRule
    parameter :foo,'event.foo'
    movement do |rule|
      rule.add_entry([{:account => 'abc',:debit=>'event.foo'}, {:account=>'def',:credit=> :foo}])
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
  
  class MockRuleDate < Tramp::PostingRule
    movement do |rule|
      rule.add_entry(:date=>Date.today, :account=>'t1', :debit=>20)
      rule.add_entry(:date=>Date.today, :account=>'t2', :credit=>20)
    end
  end
  
  class MockEventDate < Tramp::Model::Event
    rule :mock_rule_date
  end
  
