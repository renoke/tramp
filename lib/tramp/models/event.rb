module Tramp
  class Event < ActiveRecord::Base

    belongs_to :party, :class_name=>'Tramp::Party'
    belongs_to :event_type, :class_name=> 'Tramp::EventType'
    has_one :movement, :dependent=>:destroy, :validate=>true, :class_name=>'Tramp::Movement'
    has_many :entries, :through=>:movement, :class_name=>'Tramp::Entry'
    delegate :service_agreements, :to => "event_type.nil? ? [] : event_type"
  
    class << self
      def rule(name,options={})
        klass = Kernel.const_get(name.to_s.camelize) rescue Tramp::PostingRule
        if delegate = options.delete(:through)
          define_method('delegate_rule') do
            self.send(delegate).send(name)
          end
        elsif klass.respond_to?(:new)
          define_method('klass_rule') do
            klass
          end
        end
      end
    end
  
    def rule
      if self.respond_to?(:delegate_rule)
        delegate_rule.event = self
        delegate_rule
      elsif self.respond_to?(:klass_rule)
        klass_rule.new(:event=>self)
      else
        Tramp::PostingRule.new(:event=>self)
      end
    end
 
    def execution_set
      rule.eval
    end
  
    def create_movement(*arg)
      lines = execution_set.empty? ? arg : execution_set
      transaction do
        container = self.build_movement
        lines.each do |line|
          container.add_entries(line)
        end
        self.save ? container : false
      end
    end
  
    def new_movement(*arg)
      lines = rule.eval.empty? ? arg : rule.eval
      container = Tramp::Movement.new
      lines.each do |line|
        container.add_entries(line)
      end
      container
    end
  
    def delete_movement
      transaction do
        self.movement.destroy unless self.movement.nil?
        self.reload
        self.save
      end
    end

    def update_movement
      transaction do
          self.create_movement
          self.reload
          self.save
      end
    end
  end
end
