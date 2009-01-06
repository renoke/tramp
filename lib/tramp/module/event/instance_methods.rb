module Tramp
  module Event
    module InstanceMethods
=begin      
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
=end

      def rules
        tramp_rules = self.methods.find_all {|meth| meth.include?('tramp_rule_')}
        if tramp_rules.size >0 
          tramp_rules.map do |klass_rule|
            send(klass_rule).new(:event=>self)
          end
        else
          [Tramp::Model::Rule.new(:event=>self)]
        end
      end
      
      def execution_set
        rules.map{|rule| rule.eval}
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
        lines = !arg.empty? ? arg : execution_set
        container = Tramp::Model::Movement.new
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