namespace :setup do
  task :files do
    ["given_name", "family_name"].each do |set|
      ("aa".."zz").each do |prefix|
        path = "#{set}/#{prefix.first}/#{prefix}.yml"
        next if File.exists? path
        
        dir = File.dirname(path)
        FileUtils.mkdir_p dir
        FileUtils.touch path
        
      end
    end
  end
end