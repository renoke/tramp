require File.expand_path(File.dirname(__FILE__) + '/rule_utilities.rb')

module Tramp
  module Rule
    module InstanceMethods
      
      include Tramp::Rule::Utilities
    
      attr_accessor :event
      attr_reader :container, :helpers
    
      def initialize(options=nil)
        @event = options.delete(:event) if options.is_a? Hash
        @container = Tramp::RuleContainer.new if container.nil?
        @execution_set = {}
      end

      def eval
        @event.extend(helpers) unless helpers.nil?
        container.keys.map do |set|
          @execution_set[set] = send('eval_' + set.to_s)
        end
        @execution_set
      end
      
      protected
      
      def eval_secondary_events
        unless @event.nil?
          container.secondary_events.map do |event_name|
            event_class = Kernel.const_get(event_name) 
            event = event_class.new
            event.amount = @event.amount
            event
          end
        end
      end
      
      def eval_entries
        container.entries.map do |entry|
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
        container.collections.map do |collection|
          if @event.respond_to?(collection)
            @event.send(collection)
          end
        end
      end
  
    end
  end
end