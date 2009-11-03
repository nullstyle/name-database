desc "imports the census 2000 data files and merged the data with the existing data files"
task "import:census2000" => "import:census2000:run"

namespace "import:census2000" do
  task :run => :db do
    
    
    open("sources/census-2000/app_c.csv", 'r') do |file|
      
      file.gets #skip the header
      file.each do |line|
        fields = line.split(",")
        name = fields.first
        @db.family_names.get name
      end
    end
    
    @db.write
  end
end