module Tramp
  class RuleContainer
    attr_reader :entries, :collections, :secondary_events
  
    def initialize
      @entries, @collections, @secondary_events = [], [], []
    end
  
    def add_entry(*hash)
      @entries << hash
      @entries.flatten!
    end
  
    def add_collection(*name)
      @collections << name
      @collections.flatten!
    end
    
    def add_secondary_event(*class_name)
      @secondary_events << class_name
      @secondary_events.flatten!
    end
  end
end