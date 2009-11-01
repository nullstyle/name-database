class NameDatabase::File
  attr_reader :set
  attr_reader :path
  
  attr_reader :entries
  
  def initialize(set, path)
    @set = set
    @path = path
    @entries = {}
  end
  
  def get(name)
    load
    @entries[name] ||= NameDatabase::Entry.new(self.set, self, name)    
  end
  
  def write
    # convert entries to format suitable for yaml
    # write to file
    output = []
    entries.values.sort_by(&:name).each do |entry|
      if entry.meta.blank?
        output << entry.name
      else
        output << {entry.name => entry.meta.stringify_keys}
      end
    end
    
    FileUtils.mkdir_p File.dirname(path)
    open(path, 'w'){|f| f.puts YAML.dump(output) }
    
  end

  
  private
  def validate(raw)
    
  end
  
  def load    
    return unless File.exists?(path)
    raw_data = YAML.load(IO.read path)
    validate raw_data
    
    raw_data.each do |record|
      entry = NameDatabase::Entry.new(self.set, self, record)
      existing = @entries[entry.name] 
      @entries[entry.name] = existing ? existing.merge(entry) : entry
    end
  end


end