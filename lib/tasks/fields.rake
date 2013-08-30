task :fields, :names do |t, args|
  args[:names].split(' ').each do |name|
    puts "<div class=\"field\">\r"
    puts "  <%= f.label :#{name} %>\r"
    puts "  <%= f.text_field :#{name} %>\r"
    puts "</div>\r"
  end
end