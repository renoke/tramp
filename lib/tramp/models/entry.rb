module Tramp
  module Model
    class Entry < ActiveRecord::Base
    
      include Tramp::Entry::InstanceMethods
      extend  Tramp::Entry::ClassMethods
      
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