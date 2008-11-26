module Tramp
  class RuleContainer
    attr_reader :collections
  
    def initialize
      @entries, @collections =[],[]
    end
  
    def add_entry(hash)
      @entries<<hash
    end
  
    def add_collection(name)
      @collections<<name
    end
  
    def entries
      @entries.flatten
    end
  end
end