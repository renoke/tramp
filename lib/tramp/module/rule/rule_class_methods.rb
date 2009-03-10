module Tramp
  module Rule
    module ClassMethods
      
      def helpers(helper_module=nil, &block)
        if self.class == Class
          define_method('load_helpers') { helper_module || Module.new(&block)}
        else
          @helpers = helper_module || Module.new(&block)
        end
      end

      def movement(&block)
        definition_set = Tramp::RuleContainer.new

        block.arity < 1 ? definition_set.instance_eval(&block) : block.call(definition_set)
        
        if self.class == Class
          define_method('load_movement') {definition_set}
        else
          @definition_set = definition_set
        end
      end
    
    end
  end
end