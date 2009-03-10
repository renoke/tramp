module Tramp
  module Rule
    module ClassMethods

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