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

      def rule(name='', options={})
        
        if block_given? && name.empty?
         
          yield 
          
          define_method('create_anonymous_rule') do |event|
            AnonymousRule.new(:event => event)
          end
        else
          begin
            klass = Kernel.const_get(name.to_s.camelize) 
            define_method('model_rule_'+ name.to_s) do
              klass
            end
            klass
          rescue 
            raise RuntimeError, 'rule does not exist'
          end  
        end
      end

    end
  end
end