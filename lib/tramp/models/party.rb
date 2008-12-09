module Tramp
  class Party < ActiveRecord::Base
    has_and_belongs_to_many :service_agreements, :class_name=>"Tramp::ServiceAgreement" 
    has_many :events, :class_name=>"Tramp::Model::Event"
  end
end
