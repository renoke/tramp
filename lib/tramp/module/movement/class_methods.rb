module Tramp
  module Movement
    module ClassMethods
      
      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        belongs_to  :event, :class_name=>'Tramp::Model::Event', :foreign_key=>'event_id'
        has_many    :entries, :dependent=>:destroy, :class_name=>'Tramp::Model::Entry'
      end
      
    end
  end
end