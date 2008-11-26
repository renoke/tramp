module Tramp
  module RuleBuilder

    module Configuration
    
      def klass
        class<<self;self;end
      end

      def parameter(name, calcul)
          class_eval "def #{name}; #{calcul}; end\n" 
      end

      def movement(lines=[],&block)
        container = Tramp::RuleContainer.new
        yield container
        define_method('entries') do
          container.entries
        end
        define_method('collections') do
          container.collections
        end
      end
    
    end
  
    module Utilities
        def to_hash(string)
          instance_eval("{"+string+"}")
        end
      
        def convert(string)
          begin
            return Integer(string)
          rescue
            begin
              return Float(string)
            rescue
              return string
            end
          end
        end
    end
  
  end
end