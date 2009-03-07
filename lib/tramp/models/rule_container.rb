module Tramp
  class RuleContainer
    include Tramp::Rule::Utilities
    
    attr_accessor :entries, :collections, :secondary_events
  
    def initialize
      @entries, @collections, @secondary_events = [], [], []
    end
    
    def attributes
      {:entries=>@entries, :collections=>@collections, :secondary_events=>@secondary_events}
    end
    
    def keys
      instance_variables.map{|var| var.delete('@')}
    end
  end
end