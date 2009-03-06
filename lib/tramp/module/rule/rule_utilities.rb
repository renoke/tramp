module Tramp
  module Rule

    module Utilities
      
        def rule(name, &block)
          Tramp::Model::Rule.new(name, block)
        end
        
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