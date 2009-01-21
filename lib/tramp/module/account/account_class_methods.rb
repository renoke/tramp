module Tramp
  module Account
    module ClassMethods

      def self.extended(base)
        base.init_class_methods
      end
      
      def init_class_methods
        set_table_name :tramp_accounts
      end

    end
  end
end