module Tramp
  class Entry < ActiveRecord::Base
  
    belongs_to :movement, :class_name=>'Tramp::Movement'
  
    def solde(orientation='A')
      case orientation
      when 'A' then amount
      when 'D' then debit - credit
      when 'C' then credi-debit
      end
    end
  

  
  end
end