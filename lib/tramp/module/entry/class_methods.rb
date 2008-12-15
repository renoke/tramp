module Tramp
  module Entry
    module ClassMethods
      
      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        belongs_to :movement, :class_name=>'Tramp::Model::Movement'
      end
      
    end
  end
end
