require 'json'
module Tramp
  class RuleContainer
    include Tramp::Rule::Utilities
    
    attr_accessor :entries, :collections, :secondary_events
  
    def initialize
      @entries, @collections, @secondary_events = [], [], []
    end
    
    def keys
      instance_variables.map{|var| var.delete('@')}.sort
    end
    
    def to_json
      hash={}
      keys.each{|key| hash[key] = send(key)}
      hash.to_json
    end
    
    
  end
end