module Tramp
  module Model
    class Movement < ActiveRecord::Base
    
      include Tramp::Movement::InstanceMethods
      extend  Tramp::Movement::ClassMethods

    end
  end
end