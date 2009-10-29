
def path_for_name(set, name)
  "#{set}_name/#{name.first}/#{name.first(2)}.yml"
end

def entry_names(list)
  list.map do |entry|
    entry_name entry
  end.compact
end

def entry_name(entry)
  case entry
  when String: entry
  when Hash: entry.keys.first
  end
end