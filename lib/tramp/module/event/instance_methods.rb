module Tramp
  module Event
    module InstanceMethods
      
      def rule
        if self.respond_to?(:delegate_rule)
          delegate_rule.event = self
          delegate_rule
        elsif self.respond_to?(:klass_rule)
          klass_rule.new(:event=>self)
        else
          Tramp::Model::Rule.new(:event=>self)
        end
      end

      def execution_set
        rule.eval
      end

      def create_entries(*arg)
        lines = !arg.empty? ? arg : execution_set
        transaction do
          container = self.build_movement
          lines.each do |line|
            container.add_entries(line)
          end
          self.save ? container : false
        end
      end

      def new_entries(*arg)
        lines = rule.eval.empty? ? arg : rule.eval
        container = Tramp::Movement.new
        lines.each do |line|
          container.add_entries(line)
        end
        container
      end

      def delete_entries
        transaction do
          self.movement.destroy unless self.movement.nil?
          self.reload
          self.save
        end
      end

      def update_entries
        transaction do
            self.create_entries
            self.reload
            self.save
        end
      end
      
    end
  end
end