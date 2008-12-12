module Tramp
  class Movement < ActiveRecord::Base
    belongs_to  :event, :class_name=>'Tramp::Model::Event', :foreign_key=>'event_id'
    has_many    :entries, :dependent=>:destroy, :class_name=>'Tramp::Entry'

    def validate
      errors.add("entry","must be in balance") unless self.balanced?
    end

    def add_entries(*entries)
      entries.flatten.each do |entry|
        if entry.is_a? Tramp::Entry 
            self.entries << entry
        elsif entry.is_a? Hash
            self.entries << Tramp::Entry.new(entry)
        end
      end
    end
  
    def save_entries
      if self.valid?
        self.entries.each do |entry|
          entry.save
        end
      end
    end
  
    def balance
      result = 0
      self.entries.each do |entry|
        result += entry.debit
        result -= entry.credit
        result += entry.amount
      end
      result
    end
  
    def balanced?
      balance == 0 && self.entries.size >0
    end
  
    alias add_entry add_entries
  end
end