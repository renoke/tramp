module Tramp
  module Event
    module ClassMethods
      
      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        has_one :movement, :dependent=>:destroy, :validate=>true, :class_name=>'Tramp::Model::Movement',
                :foreign_key=>:event_id
        has_many :entries, :through=>:movement, :class_name=>'Tramp::Model::Entry'
        has_many :secondary_events, :class_name=> 'Tramp::Model::Event', :foreign_key=>:event_id
        set_table_name :tramp_events
      end

      def rule(name,options={})
        klass = Kernel.const_get(name.to_s.camelize) rescue Tramp::Model::Rule
        if delegate = options.delete(:through)
          define_method('delegate_rule') do
            self.send(delegate).send(name)
          end
        elsif klass.respond_to?(:new)
          define_method('tramp_rule_'+ name.to_s) do
            klass
          end
        end
        klass
      end

    end
  end
end