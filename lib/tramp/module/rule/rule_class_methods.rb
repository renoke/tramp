module Tramp
  module Rule
    module ClassMethods
      
      def helpers(helper_module=nil, &block)
        if self.class == Class
          define_method('helpers') { helper_module || Module.new(&block)}
        else
          @helpers = helper_module || Module.new(&block)
        end
      end

      def movement(&block)
        container = Tramp::RuleContainer.new

        block.arity < 1 ? container.instance_eval(&block) : block.call(container)
        
        if self.class == Class
          define_method('container') {container}
        else
          @container = container
        end
      end
    
    end
  end
end