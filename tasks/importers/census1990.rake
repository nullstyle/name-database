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
          
          
          entry.meta[:gender] = case entry.meta[:gender]
                                when "female", "unisex" then
                                  "unisex"
                                else
                                  "male"
                                end
        end
      end
      
    end
      
    task :female => :db do
      open("sources/census-1990/dist.female.first", 'r') do |file|        
        file.each do |line|
          fields = line.split(/\s+/)
          name = fields.first
          entry = @db.given_names.get name
          
          entry.meta[:gender] = case entry.meta[:gender]
                                when "male", "unisex" then
                                  "unisex"
                                else
                                  "female"
                                end
        end
      end
    end
        
    task :family => :db do
      open("sources/census-1990/dist.all.last", 'r') do |file|        
        file.each do |line|
          fields = line.split(/\s+/)
          name = fields.first
          @db.family_names.get name
        end
      end
    end
    
    
  end
end