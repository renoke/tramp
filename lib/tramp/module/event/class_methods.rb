module Tramp
  module Event
    module ClassMethods
      
      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        belongs_to :party, :class_name=>'Tramp::Party'
        belongs_to :event_type, :class_name=> 'Tramp::EventType'
        has_one :movement, :dependent=>:destroy, :validate=>true, :class_name=>'Tramp::Model::Movement',
                :foreign_key=>:event_id
        has_many :entries, :through=>:movement, :class_name=>'Tramp::Model::Entry'
        delegate :service_agreements, :to => "event_type.nil? ? [] : event_type"
        set_table_name :events
      end

      def rule(name,options={})
        klass = Kernel.const_get(name.to_s.camelize) rescue Tramp::Model::Rule
        if delegate = options.delete(:through)
          define_method('delegate_rule') do
            self.send(delegate).send(name)
          end
        elsif klass.respond_to?(:new)
          define_method('klass_rule') do
            klass
          end
        end
        klass
      end

    end
  end
end