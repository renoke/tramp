module Tramp
  class ServiceAgreement < ActiveRecord::Base
  
    belongs_to :event_type, :class_name=>'Tramp::EventType'
    belongs_to :posting_rule, :class_name=>'Tramp::PostingRule'
    has_and_belongs_to_many :parties
  
  end
end