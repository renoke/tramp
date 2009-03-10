require File.expand_path(File.dirname(__FILE__) + '/rule_utilities.rb')

module Tramp
  module Rule
    module InstanceMethods
      
      include Tramp::Rule::Utilities
    
      attr_accessor :event
      attr_reader :definition_set
      
      alias :container :definition_set
    
      def initialize(options=nil)
        @event = options.delete(:event) if options.is_a? Hash
        load_definition_set
        @execution_set = {}
      end

      def eval
        @definition_set.keys.map do |set|
          @execution_set[set] = send('eval_' + set.to_s)
        end
        @execution_set
      end
      
      def load_definition_set
        #helpers
        @event.extend(load_helpers) if respond_to?(:load_helpers)
        
        #movement
        @definition_set = if respond_to?(:load_movement)
          load_movement
        else
          Tramp::RuleContainer.new
        end
      end
      
      protected
      
      def eval_secondary_events
        @definition_set.secondary_events.map do |event_name|
          unless event_name == nil
            event_class = Kernel.const_get(event_name) 
            event = event_class.new
            event.amount = @event.amount
            event
          end
        end
      end
      
      def eval_entries
        @definition_set.entries.map do |entry|
          if entry.is_a? Hash
            entry.inject({}) do |hash,(key,value)|
              if value.is_a? String or value.is_a? Symbol
                if @event.respond_to? value
                  hash[key] = @event.send(value)
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
        @definition_set.collections.map do |collection|
          if @event.respond_to?(collection)
            @event.send(collection)
          end
        end
      end
  
    end
  end
end