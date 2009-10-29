task :validate_data do
  paths = Dir["{given,family}_name/**/*.yml"]
  pad_length = 55
  
  paths.each do |path|
    begin
      STDOUT.write path.ljust(pad_length, '.')
      loaded = YAML.load(IO.read path)
      puts "success"
    rescue ArgumentError => e
      puts "failed"
      puts e.message
      puts
    end
  end
end