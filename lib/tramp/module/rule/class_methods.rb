module Tramp
  module Rule

    module ClassMethods
      
      def self.included(base)
        base.send :init_association
        base.send 'set_table_name :posting_rules'
      end
    
      def klass
        class<<self;self;end
      end
      
      def init_association
        has_many :service_agreements, :class_name => 'Tramp::ServiceAgreement'
      end

      def parameter(name, calcul)
          class_eval "def #{name}; #{calcul}; end\n" 
      end

      def movement(lines=[],&block)
        container = Tramp::RuleContainer.new
        yield container
        define_method('entries') do
          container.entries
        end
        define_method('collections') do
          container.collections
        end
      end
    
    end
  
  end
end