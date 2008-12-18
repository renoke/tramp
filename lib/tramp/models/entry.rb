module Tramp
  module Model
    class Entry < ActiveRecord::Base
    
      include Tramp::Entry::InstanceMethods
      extend  Tramp::Entry::ClassMethods
      

    end
  end
end