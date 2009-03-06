module Tramp
  module Model
    class Rule #< ActiveRecord::Base
    
    include Tramp::Rule::InstanceMethods
    extend  Tramp::Rule::ClassMethods

    end
  end
end