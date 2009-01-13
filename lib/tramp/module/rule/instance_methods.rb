require File.expand_path(File.dirname(__FILE__) + '/utilities.rb')

module Tramp
  module Rule
    module InstanceMethods
      
      include Tramp::Rule::Utilities
    
      attr_accessor :event
      attr_reader :entries
    
      def initialize(options=nil)
        @event = options.delete(:event) if options.is_a? Hash
        super(options)
      end
  
      def eval_parameters
        self.parameter.split("\n").each do |line|
          define_parameter(line.split("="))
        end
      end
  
      def define_parameter(array)
        if array.size==2
          class_eval "def #{array[0]}; #{array[1]}; end\n"
        end
      end
  
      def convert_entries
        entry.gsub(' ','').split("\n").map do |line|
          hash = {}
          line.split(",").each do |set|
            kv = set.split("=")
            hash[kv[0].to_sym]=convert(kv[1])
          end
          hash
        end
      end

      def eval
        @eval = {}
        @eval[:entries]=eval_own_entries unless entries.nil?
        @eval[:collections] = eval_own_collections if respond_to?(:collections)
        @eval[:secondary_events] = eval_secondary_events if respond_to?(:secondary_events)
        @eval
      end

=begin  
      def process(event)
        @event = event
        eval_parameters unless parameter.blank?
        @entries = self.entry.split("\n").map{|entry| to_hash(entry)}
      end
=end

      def eval_secondary_events
        secondary_events.map do |event_name|
          unless event_name == nil
            event_class = Kernel.const_get(event_name) 
            event = event_class.new
            event.amount = self.amount
            event
          end
        end
      end
      
      def eval_own_entries
        entries.map do |entry|
          if entry.is_a? Hash
            entry.inject({}) do |hash,(key,value)|
              if value.is_a? Symbol and self.respond_to?(value)
                hash[key] = self.send(value)
              elsif value.class.to_s == 'String' and value.include?('.')
                hash[key] = value.to_s.split('.').inject(self) {|result,method| result.send(method)}
              elsif value.is_a? String and self.respond_to?(value)
              else
                hash[key] = value
              end
              hash
            end
          end
        end   
      end
  
      def eval_own_collections
        collections.map do |collection|
          if event.respond_to?(collection)
            event.send(collection)
          end
        end
      end
  
      protected :eval_own_entries, :eval_own_collections
    end
  end
end