
desc "imports the census 2000 data files and merged the data with the existing data files"
task "import:census1990" => "import:census1990:run"

namespace "import:census1990" do
    
  task :run => [:db, "import:census1990:male", "import:census1990:female", "import:census1990:family"] do
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