require 'active_support'

class NameDatabase
  require 'name-database/set'
  
  attr_reader :given_names
  attr_reader :family_names
  
  def initialize(dir = File.dirname(__FILE__) + "/..")
    
    @given_names = NameDatabase::Set.new(dir + "/given_name")
    @family_names = NameDatabase::Set.new(dir + "/family_name")
    
  end
  
  def write
    @given_names.write
    @family_names.write
  end
end