module Tramp
  class EventType < ActiveRecord::Base
  
    has_many :events, :class_name => 'Tramp::Model::Event'
    has_many :service_agreements, :class_name => 'Tramp::ServiceAgreement'
  
  end
end