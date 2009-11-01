class NameDatabase::Entry
  attr_reader :name
  attr_reader :set
  attr_reader :file
  attr_reader :meta
  
  attr_reader :line
  
  def initialize(set, file, data)
    @set = set
    @file = file
    
    case data
    when String then
      @name = data
      @meta = {}.with_indifferent_access
    when Hash then
      @name = data.keys.first
      @meta = data.values.first.with_indifferent_access
    end
  end
  
  
  def path()
    set.data_file_path(name)
  end
  
  def merge(other)
    new_data = {name => meta.merge(other.meta)}
    NameDatabase::Entry.new(self.set, self.file, new_data)
  end
  
end