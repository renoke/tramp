require File.expand_path(File.dirname(__FILE__) + '/rule_utilities.rb')

module Tramp
  module Rule
    module InstanceMethods
      
      include Tramp::Rule::Utilities
    
      attr_accessor :event
      attr_reader :entries
    
      def initialize(options=nil)
        @event = options.delete(:event) if options.is_a? Hash
      end
      
      def container
        if respond_to? :class_container
          class_container
        else
          Tramp::RuleContainer.new
        end
      end
      

      def eval
        @eval = {}
        @eval[:entries]=eval_entries
        @eval[:collections] = eval_collections
        @eval[:secondary_events] = eval_secondary_events
        @eval
      end

      def eval_secondary_events
        container.secondary_events.map do |event_name|
          unless event_name == nil
            event_class = Kernel.const_get(event_name) 
            event = event_class.new
            event.amount = self.event.amount
            event
          end
        end
      end
      
      def eval_entries
        container.entries.map do |entry|
          if entry.is_a? Hash
            entry.inject({}) do |hash,(key,value)|
              if value.is_a? String or value.is_a? Symbol
                if self.respond_to? value
                  hash[key] = @event.instance_eval(send(value))
                elsif @event.respond_to? value
                  hash[key] = @event.send(value)
                elsif value.is_a? String
                  begin
                    hash[key] = @event.instance_eval(value)
                  rescue
                    hash[key] = value
                  end
                 else
                   hash[key] = value.to_s
                end
              else 
                hash[key] = value
              end
              hash
            end
          end
        end   
      end
  
      def eval_collections
        container.collections.map do |collection|
          if event.respond_to?(collection)
            event.send(collection)
          end
        end
      end
  
      #protected :eval_own_entries, :eval_own_collections
    end
  end
end