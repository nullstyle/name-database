require 'sequel'

task "export:sqlite" => [:db, "export:sqlite:schema"] do
  
  #first insert the given_names
  @names = @output[:names]
  @meta = @output[:metadata]
  
  puts "dumping given names"
  @db.given_names.each do |entry|
    row = @names.insert :name => entry.name, :type => "given"
    
    entry.metadata_without_nesting.each do |key, value|
      @meta.insert :key => key, :value => value
    end
  end
  
  # puts "dumping family names"
  # @db.family_names.each do |entry|
  #   @names << {:name => entry.name, :type => "family"}
  # end
  
end

namespace "export:sqlite" do
  task :db => "out" do
    
    existing = Dir["out/*.sqlite"].length
    path = "out/names#{(".#{existing}" if existing > 0)}.sqlite"
    
    @output = Sequel.sqlite(path)
  end
  
  task :schema => "export:sqlite:db" do
    
    @output.create_table :names do
      primary_key :id
      String :name
      String :type
      
      index [:type, :name]
    end
    
    @output.create_table :metadata do
      foreign_key :name_id, :names
      String :key
      String :value
      
      index [:name_id, :key]
    end
    
  end
end