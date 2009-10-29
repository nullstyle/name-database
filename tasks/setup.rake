["given", "family"].each do |set|
  ("aa".."zz").each do |prefix|
    path = "#{set}_name/#{prefix.first}/#{prefix}.yml"
    dir = File.dirname(path)
    directory dir
    file path => dir do
      open(path, "w") do |f|
        f.puts "---"
        f.puts "# This file contain #{set} names starting with #{prefix}"
      end
    end
  end
end