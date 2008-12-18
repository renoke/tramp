module Tramp
  module Entry
    module InstanceMethods
      
      def solde(orientation='A')
        case orientation
        when 'A' then self.amount.to_f
        when 'D' then self.debit.to_f  - self.credit.to_f
        when 'C' then self.credit.to_f - self.debit.to_f
        end
      end
      
    end
  end
end