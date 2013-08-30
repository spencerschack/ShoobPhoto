task :grid do
  12.times.each do |no|
    pixels = (no+1)*50+no*30
    puts "#{no+1} columns are #{pixels}px wide\r"
  end
end

task :mix do
  (1..9).to_a.each do |len|
    mixer = []
    while
      mixer = []
      len.times.each_with_index do |n, i|
        while
          s = rand(len/2)-len
          if (0..(len-1)).include?(s+i)
            mixer << s
            break
          end
        end
      end
      if mixer.each_with_index.map{|n,i| n+i}.uniq.count == mixer.count
        break
      end
    end
    puts "#{len} => #{mixer.inspect},"
  end
end

task :images => :environment do
  Dir.foreach("#{Rails.root}/public/images/senior_portraits/") do |filename|
    begin
      geo = Paperclip::Geometry.from_file("#{Rails.root}/public/images/senior_portraits/#{filename}")
      puts "<img title=\"#{filename.split('.')[0]}\" src=\"/images/senior_portraits/#{filename}\" width=\"#{geo.width.to_i}\" height=\"#{geo.height.to_i}\" />"
    rescue
      nil
    end
  end
end