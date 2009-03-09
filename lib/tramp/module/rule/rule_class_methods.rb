module Tramp
  module Rule
    module ClassMethods
      
      def helpers(helper_module=nil, &block)
        define_method('load_helpers') do
          helper_module || Module.new(&block)
        end
      end

      def movement(&block)
        container = Tramp::RuleContainer.new

        block.arity < 1 ? container.instance_eval(&block) : block.call(container)
        
        define_method('load_movement') do
          container
        end
      end
    
    end
  end
end