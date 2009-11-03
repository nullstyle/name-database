directory "out"

task "clean" do
  FileUtils.rm_rf "out"
end

["given", "family"].each do |set|
  
  rule Regexp.new("name:#{set}:[a-z]+") do |t|
    name = t.name.gsub("name:#{set}:", '')
    path = path_for_name(set, name)

    Rake::Task[path].invoke
    
    parsed = YAML.load(IO.read path)
    parsed ||= []
    
    next if entry_names(parsed).index(name)
    parsed << name
    parsed.sort!{|l,r| entry_name(l) <=> entry_name(r)}
    open(path, 'w'){|f| f.puts YAML.dump(parsed) }
  end
  
  # opens a textmate window to the appropriate file and line of the name specified
  rule Regexp.new("mate:#{set}:[a-z]+") => [proc{|name| name.gsub("mate:", "name:")}] do |t|
    
  end
end

task :default => :db do

  entry = @db.family_names.get "smith"
  
  @db.write
end

task :db do
  $:.unshift File.dirname(__FILE__) + "/../lib"
  require 'name-database'
  
  @db = NameDatabase.new(".")
end