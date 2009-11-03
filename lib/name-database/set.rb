class NameDatabase::Set
  require 'name-database/file'
  require 'name-database/entry'
  
  attr_reader :base_path
  attr_reader :parsed_files
  
  def initialize(base_path)
    @base_path = base_path
    @parsed_files = {}
  end
  
  def get(name)
    name = normalize_name name
    data_path = data_path_file(name)
    file = get_file(data_path)
    
    file.get(name)
  end
  
  def data_path_file(name)
    "#{base_path}/#{name.first}/#{name.first(2)}.yml"
  end
  
  def write
    parsed_files.values.each(&:write)
  end
  
  def all_files
    Dir["#{base_path}/**/*.yml"].map{|p| get_file(p)}
  end
  
  def each(&block)
    all_files.each do |file|
      file.each(&block)
    end
  end
  
  private
  def get_file(path)
    parsed_files[path] ||= NameDatabase::File.new(self, path)
  end
  
  def normalize_name(name)
    name.downcase
  end
end