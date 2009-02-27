module Tramp
  class RuleContainer
    attr_reader :entries, :collections, :secondary_events
  
    def initialize
      @entries, @collections, @secondary_events = [], [], []
    end
  
    def add_entry(*hash)
      @entries.concat hash
    end
  
    def add_collection(*name)
      @collections.concat name
    end
    
    def add_secondary_event(*class_name)
      @secondary_events.concat class_name
    end
  end
end