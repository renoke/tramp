require 'test/unit'
require 'rubygems'
require 'active_record'
require 'active_support/test_case'

require File.expand_path(File.dirname(__FILE__) + '/../init')
require File.expand_path(File.dirname(__FILE__) + '/../generators/tramp/templates/create_tramp') #database for test

ActiveRecord::Base.establish_connection(:adapter=>'sqlite3', :dbfile=>':memory:')
ActiveRecord::Migration.verbose = false
TrampMigration.migrate(:up)
Currency.create(:alphabetic_code => 'CHF', :minor_unit=>2)
Currency.create(:alphabetic_code => 'EUR', :minor_unit=>2)
ActiveRecord::Migration.verbose = true

require File.expand_path(File.dirname(__FILE__) + '/tramp_test_helper')     #setup fixturs & mocks



     
class ActiveSupport::TestCase
  
  def setup

  end
  
  def teardown

  end

  
end



