module Tramp
  class Account < ActiveRecord::Base 

    @@from  = Date.today.beginning_of_year
    @@to    = Date.today
  
    def entries(from = @@from, to = @@to)
      Tramp::Model::Entry.find(:all, :conditions=>[
        "account = ? and date between ? and ?", self.code, from, to])
    end
  
    def balance(from = @@from,to=@@to)
      entries(from,to).inject(0){|result,entry| entry.solde(orientation)}
    end
  
    def deposits(from=@@from,to=@@to)
      entries(from,to).inject(0){|result,entry| entry.solde(orientation) if entry.solde(orientation) >0} || 0
    end
  
    def withdrawls(from=@@from,to=@@to)
      entries(from,to).inject(0){|result,entry| entry.solde(orientation) if entry.solde(orientation) <0} || 0
    end

  end
end