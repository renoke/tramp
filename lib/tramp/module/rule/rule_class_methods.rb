module Tramp
  module Rule
    module ClassMethods
      
      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        set_table_name 'tramp_rules'
      end
      
      def parameter(hash)
        hash.each do |key, value|
          define_method(key) do
            value
          end
        end
      end

      def movement(lines=[],&block)
        container = Tramp::RuleContainer.new
        yield container
        
        define_method('class_container') do
          container
        end
      end
    
    end
  end
end