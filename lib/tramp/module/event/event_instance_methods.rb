module Tramp
  module Event
    module InstanceMethods

      def rules
        rules = []
        model_rules = self.methods.find_all {|meth| meth.include?('model_rule_')}
        if model_rules.size > 0 
          model_rules.each do |rule|
            rules << send(rule).new(:event=>self)
          end
        elsif self.respond_to? 'create_anonymous_rule'
          rules << create_anonymous_rule(self)
        else
          rules << Tramp::Model::Rule.new(:event=>self)
        end
        rules
      end
      
      def execution_set
        rules.map{|rule| rule.eval}
      end

      def create_entries(*arg)
        transaction do
          self.movement = movement_factory(arg)
          self.save
        end
      end

      def new_entries(*arg)
        self.movement = movement_factory(arg)
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
      
      def secondary_event_factory
        execution_set.map do |set|
          events = set[:secondary_events].map do |event|
            if event.create_entries
              self.secondary_events << event
              event.save
              event
            else
              event 
            end
          end
        end
      end
      
      
      #protected
      
      def movement_factory(arg)
        mvmt = Tramp::Model::Movement.new
        mvmt.add_entries(arg) if arg
        execution_set.each do |set|
          set.each do |key,values|
            case 
            when key == :entries then mvmt.add_entries(values)
            when key == :collections  then mvmt.add_entries(values)
            end
          end
        end
        mvmt
      end
      
    end
  end
end