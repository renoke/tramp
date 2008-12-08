require File.expand_path(File.dirname(__FILE__) + '/utilities.rb')

module Tramp
  module Rule
    module InstanceMethods
    
      attr_accessor :event
      attr_reader :entries
  
      include Tramp::Rule::Utilities

      def initialize(options=nil)
        @event = options.delete(:event) if options.is_a? Hash
        @eval = []
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
        @eval<<eval_entries unless entries.nil?
        @eval<<eval_collections if respond_to?(:collections)
        @eval.flatten
      end
  
      def process(event)
        @event = event
        eval_parameters unless parameter.blank?
        @entries = self.entry.split("\n").map{|entry| to_hash(entry)}
      end

  
      def eval_entries
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
  
      def eval_collections
        collections.map do |collection|
          if event.respond_to?(collection)
            event.send(collection)
          end
        end
      end
  
      protected :eval_entries, :eval_collections
    end
  end
end