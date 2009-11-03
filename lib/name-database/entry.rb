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
  
  def metadata_without_nesting
    returning({}) do |result|
      NameDatabase::Entry.flattened_meta("", result, meta)
    end
  end
  
  def self.flattened_meta(prefix, result, meta)
    meta.each do |key, value|
      flattened_key = prefix.blank? ? key : "#{prefix}/#{key}"
      
      case value
      when Hash
        result.merge! flattened_meta(flattened_key, result, value)
      else
        result[flattened_key] = value
      end
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