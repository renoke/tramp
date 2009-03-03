module Tramp
  module Rule
    module ClassMethods
      
      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        set_table_name 'tramp_rules'
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