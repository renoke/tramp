module Tramp
  module Model
    class Account < ActiveRecord::Base 
      
      extend  Tramp::Account::ClassMethods
      include Tramp::Account::InstanceMethods


    end
  end
end