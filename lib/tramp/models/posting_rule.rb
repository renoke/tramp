#require File.expand_path(File.dirname(__FILE__) + '/../../tramp_modules')
module Tramp
  module Model
    class PostingRule < ActiveRecord::Base
    
    include Tramp::Rule::InstanceMethods
    extend  Tramp::Rule::ClassMethods

    end
  end
end