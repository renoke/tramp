
class TrampMigration < ActiveRecord::Migration

  def self.up

    create_table "tramp_accounts" do |t|
      t.string   "code"
      t.string   "label"
      t.string   "orientation"
      t.boolean  "agregator"
      t.integer  "parent_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "tramp_entries" do |t|
      t.date     "date"
      t.string   "account"
      t.string   "sublabel"
      t.integer  "debit",       :default => 0
      t.integer  "credit",      :default => 0
      t.integer  "amount",      :default => 0
      t.string   "currency"
      t.string   "orientation"
      t.integer  "movement_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "tramp_events" do |t|
      t.string   "code"
      t.string   "label"
      t.integer  "amount"
      t.integer  "piece"
      t.date     "when_occured"
      t.date     "when_noticed"
      t.integer  "event_type_id"
      t.integer  "party_id"
      t.string   "type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "tramp_movements" do |t|
      t.integer  "event_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "tramp_rules" do |t|
      t.string   "code"
      t.string   "label"
      t.date     "date_begin"
      t.date     "date_end"
      t.string   "amount"
      t.string   "parameter"
      t.string   "entry"
      t.integer  "event_type_id"
      t.string   "type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "tramp_currencies" do |t|
      t.string  'name'
      t.string  'alphabetic_code'
      t.integer 'numeric_code'
      t.integer 'minor_unit'
    end
    
    add_index(:tramp_accounts,    :code)
    add_index(:tramp_entries,     :account)
    add_index(:tramp_currencies,  :alphabetic_code,  :unique=>true)
    add_index(:tramp_currencies,  :numeric_code,     :unique=>true)
  
  end
  
  def self.down
    drop_table :tramp_accounts
    drop_table :tramp_entries
    drop_table :tramp_events
    drop_table :tramp_movements
    drop_table :tramp_rules
    drop_table :tramp_currencies
  end
end