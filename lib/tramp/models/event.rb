module Tramp
  module Model
    class Event < ActiveRecord::Base

      include Tramp::Event::InstanceMethods
      extend  Tramp::Event::ClassMethods
  
    end
  end
end
