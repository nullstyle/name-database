namespace :importers do
  namespace :census1990 do
    
    desc "imports the census 2000 data files and merged the data with the existing data files"
    task :run => [:db, "importers:census1990:male", "importers:census1990:female", "importers:census1990:family"] do
      @db.write
    end
    
    task :male => :db do
      
      open("sources/census-1990/dist.male.first", 'r') do |file|        
        file.each do |line|
          fields = line.split(/\s+/)
          name = fields.first
          entry = @db.given_names.get name
          entry.meta[:gender] = "male"
        end
      end
      
    end
      
    task :female => :db do
      
    end
        
    task :family => :db do
      
    end
    
    
  end
end