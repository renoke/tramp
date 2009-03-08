module Tramp
  module Rule
    module ClassMethods
      
      def helpers(helper_module=nil, &block)
        define_method('class_helpers') do
          helper_module || Module.new(&block)
        end
      end

      def movement(&block)
        container = Tramp::RuleContainer.new
        yield container
        
        define_method('class_container') do
          container
        end
      end
    
    end
  end
end