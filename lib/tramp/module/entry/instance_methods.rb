module Tramp
  module Entry
    module InstanceMethods
      
      def solde(orientation='A')
        case orientation
        when 'A' then amount
        when 'D' then debit - credit
        when 'C' then credi-debit
        end
      end
      
    end
  end
end