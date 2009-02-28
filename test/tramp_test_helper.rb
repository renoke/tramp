
  
  
  class MockRule < Tramp::Model::Rule
    parameter :foo,'event.foo'
    movement do |rule|
      rule.entries<<({:account => 'abc',:debit=>'event.foo'})
      rule.entries<< {:account=>'def',:credit=> :foo}
      rule.collections<<('posts')
      rule.secondary_events<<('MockEventDate')
    end
  end

  class MockEvent < Tramp::Model::Event
    attr_accessor :foo
    rule :mock_rule
    def initialize
      @foo=20
      super
    end
    
    def posts
      [{:account => 'post_debit',:debit=>100}, {:account=>'post_credit',:credit=> 100}]
    end
  end
  
  class MockRuleDate < Tramp::Model::Rule
    movement do |rule|
      rule.entries<<({:date=>Date.today, :account=>'t1', :debit=>20})
      rule.entries<<({:date=>Date.today, :account=>'t2', :credit=>20})
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
  
  
