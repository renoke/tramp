module Tramp
  module Entry
    module ClassMethods
      
      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        belongs_to :movement, :class_name=>'Tramp::Model::Movement'
        
        composed_of :debit, 
                    :class_name => "Money", 
                    :mapping => [ %w(debit amount), %w(currency currency) ],
                    :converter => :convert,
                    :constructor => :construct

        composed_of :credit, 
                    :class_name => "Money", 
                    :mapping => [ %w(credit amount), %w(currency currency) ],
                    :converter => :convert,
                    :constructor => :construct

        composed_of :amount, 
                    :class_name => "Money", 
                    :mapping => [ %w(amount amount), %w(currency currency) ],
                    :converter => :convert,
                    :constructor => :construct
      end
      
    end
  end
end
