require 'ftools'
task :move do
  ['/wp-content/uploads/2010/03/Eighth-Grade-Summary.pdf', '/wp-content/uploads/2010/03/Seventh-Grade-Summary.pdf', '/wp-content/uploads/2010/03/Sixth-Grade-Summary.pdf', '/wp-content/uploads/2010/03/Fifth-Grade.pdf', '/wp-content/uploads/2010/03/Fourth-Grade.pdf', '/wp-content/uploads/2010/03/Third-Grade-Summary.pdf', '/wp-content/uploads/2010/03/Second-Grade-Summary.pdf', '/wp-content/uploads/2010/03/First-Grade-Summary.pdf'].each do |filename|
    if File.copy("/home/shoobphotography/old#{filename}", "#{Rails.root}/public/downloads")
      puts "MOVED "
    else
      puts "FAILED "
    end
    puts "#{filename} TO #{Rails.root}/public/downloads"
  end
end

task :packages => :environment do
  pt = PackageType.find_by_slug('yearbooks')
  pt.school_ids = Package.find_by_slug('yearbook').prices.map(&:school_id)
  puts pt.save
end

task :schools => :environment do
  { "Sonoma" => "elementary", "Our Lady Of Fatima" => "elementary", "Roosevelt" => "middle", "Sam Vaughn" => "elementary", "San Andreas" => "elementary", "Orchard" => "elementary", "Northmead" => "elementary", "Miano" => "elementary", "Enochs" => "high"  , "Davis" => "high", "Downey" => "high", "Modesto" => "high", "Johansen" => "high", "Gregori" => "high", "Merced" => "high", "Sierra" => "high", "East Union" => "high", "Escalon" => "high", "Riverbank" => "high", "Adkison" => "elementary", "Apricot Valley" => "elementary", "Carroll Fowler" => "elementary", "Central" => "elementary", "Chrysler" => "elementary", "Curtis Creek" => "elementary", "Dieterich" => "elementary", "Eisenhut" => "elementary", "El Vista" => "elementary", "Enslen" => "elementary", "Everett" => "elementary", "Hanshaw" => "middle", "Hopeton" => "elementary", "Jenny Lind" => "elementary", "John Adams" => "elementary", "La Loma" => "middle", "Lakewood" => "elementary", "Louis Bohn" => "elementary", "Martone" => "elementary", "Mckinley" => "elementary", "Merquin" => "elementary", "St. Stanislaus" => "elementary", "Stanislaus" => "elementary", "Summerville" => "elementary", "Golden Valley" => "high", "Washington" => "elementary", "Waterford" => "high", "Waterloo" => "middle", "Weston" => "elementary", "Washington (George)" => "elementary", "Williams" => "middle", "C.F. Brown" => "elementary", "Las Palmas" => "elementary", "Marshall" => "elementary", "Mesa Verde" => "elementary", "Prescott" => "middle", "Rising Sun" => "elementary", "Stockard Coffee" => "elementary", "Kingsburg" => "high", "French Camp" => "elementary", "Grayson" => "elementary", "Julien" => "elementary", "Lincoln" => "elementary", "Park View" => "elementary", "Wakefield" => "elementary", "Columbia" => "elementary", "Whitmore Charter/Berryhill" => "elementary", "Sonora" => "high", "Earle Williams" => "middle" }.each do |school, type|
    if School.create({:title => school, :school_type_id => SchoolType.find_by_title(type.capitalize).id})
      puts "CREATED"
    else
      puts "FAILED"
    end
    puts school
  end
end

task :input => :environment do
  assign = <<DOC
Waterford => 3
Merced => 3
Davis => 3
Sonora => 3
Downey => 3
East Union => 3
Sierra => 3
Enochs => 3
Enochs => 3
East Union => 3
Gregori => 3
Escalon => 3
Modesto => 3
Riverbank => 3
Sierra => 3
Johansen => 3
Davis => 3
East Union => 3
Downey => 3
Golden Valley => 3
Salida => 3
Merced => 3
Sonora => 3
Creekside => 3
St. Stanislaus => 4
John Adams => 4
Merquin => 4
Mesa Verde => 4
Stockard Coffee => 4
Marshall => 4
Sam Vaughn => 4
Jenny Lind => 4
El Vista => 4
Sonoma => 4
San Andreas => 4
Apricot Valley => 4
Chrysler => 4
Orchard => 4
El Vista => 4
Our Lady Of Fatima => 4
Waterloo => 4
Weston => 4
Carroll Fowler => 4
Louis Bohn => 4
Curtis Creek => 4
Salida => 4
Miano => 4
Hopeton => 4
Washington => 4
Central => 4
Stanislaus => 4
Miano => 4
Whitmore Charter/Berryhill => 4
Dieterich => 4
Enslen => 4
Bret Harte => 4
Northmead => 4
Las Palmas => 4
Summerville => 4
Martone => 4
Wakefield => 4
Wicklund => 4
Martone => 4
Mesa Verde => 4
Adkison => 4
Eisenhut => 4
Lakewood => 4
C.F. Brown => 4
Everett => 4
St. Stanislaus => 4
Chrysler => 5
Sam Vaughn => 5
Central => 5
Lakewood => 5
Everett => 5
Grayson => 5
Our Lady Of Fatima => 5
Summerville => 5
Weston => 5
Waterloo => 5
Davis => 5
Downey => 5
East Union => 5
Modesto => 5
Riverbank => 5
Hanshaw => 5
Sierra => 5
Enochs => 5
Escalon => 5
Johansen => 5
Washington => 5
Golden Valley => 5
Merced => 5
Sonora => 5
Summerville => 5
Cesar Chavez => 9
El Portal => 9
Northmead => 1
Everett => 1
Sam Vaughn => 1
Marshall => 1
Eisenhut => 1
Dieterich => 1
Lakewood => 1
Central => 1
La Loma => 1
Earle Williams => 1
Louis Bohn => 1
C.F. Brown => 1
Carroll Fowler => 1
Jenny Lind => 1
Stockard Coffee => 1
Curtis Creek => 1
Miano => 1
Roosevelt => 1
Martone => 1
Weston => 1
Miano => 1
Chrysler => 1
Grayson => 1
Adkison => 1
Merquin => 1
Mesa Verde => 1
Stanislaus => 1
Washington => 1
Hopeton => 1
John Adams => 1
Our Lady Of Fatima => 1
San Andreas => 1
St. Stanislaus => 1
El Vista => 1
Enslen => 1
Las Palmas => 1
Orchard => 1
Apricot Valley => 1
Martone => 1
Golden Valley => 2
Golden Valley => 2
Downey => 2
Downey => 2
Golden Valley => 2
East Union => 2
East Union => 2
Enochs => 2
Prescott => 2
East Union => 2
Davis => 2
Merced => 2
La Loma => 2
Merced => 2
East Union => 2
St. Stanislaus => 2
Davis => 2
Roosevelt => 2
Davis => 2
Sierra => 2
East Union => 2
East Union => 2
Prescott => 2
East Union => 2
East Union => 2
East Union => 2
Golden Valley => 2
Golden Valley => 2
Jenny Lind => 2
Enochs => 2
Enochs => 2
Enochs => 2
Merced => 2
Downey => 2
Golden Valley => 2
Downey => 2
Enochs => 2
Merced => 2
Modesto => 2
Gregori => 2
Modesto => 2
Gregori => 2
Merced => 2
Gregori => 2
East Union => 2
Gregori => 2
Merced => 2
Enochs => 2
Enochs => 2
Enochs => 2
Downey => 2
Prescott => 2
Davis => 2
Davis => 2
Our Lady Of Fatima => 2
St. Stanislaus => 2
East Union => 2
Downey => 8
Downey => 8
Enochs => 8
Davis => 8
Gregori => 8
Modesto => 8
Davis => 8
Downey => 8
Modesto => 8
Gregori => 8
Downey => 8
Modesto => 8
Enochs => 8
East Union => 8
Merced => 8
Davis => 8
Davis => 8
Escalon => 8
East Union => 8
Modesto => 8
Merced => 8
Downey => 8
Escalon => 8
Sierra => 8
Sierra => 8
Sonora => 8
Sierra => 7
Sierra => 7
Sierra => 7
East Union => 7
East Union => 7
Stockard Coffee => 7
Escalon => 7
Chrysler => 7
Orchard => 7
Escalon => 7
Lincoln => 7
French Camp => 7
Escalon => 7
Our Lady Of Fatima => 7
Louis Bohn => 7
Las Palmas => 7
Martone => 7
Our Lady Of Fatima => 7
Our Lady Of Fatima => 7
Waterloo => 7
Davis => 7
Gregori => 7
Escalon => 7
Escalon => 7
French Camp => 7
Las Palmas => 7
Wakefield => 7
Escalon => 7
Golden Valley => 7
French Camp => 7
Dieterich => 7
Eisenhut => 7
Sierra => 7
Sierra => 7
Sierra => 7
Sierra => 7
Martone => 7
Orchard => 7
Sierra => 7
Sierra => 7
Hanshaw => 7
Sierra => 7
Merced => 7
Sierra => 7
Wakefield => 7
Sierra => 7
Sierra => 7
Charleston => 7
Sam Vaughn => 7
Davis => 7
Gregori => 7
Gregori => 7
Northmead => 7
Sonora => 7
Escalon => 7
Escalon => 7
Gregori => 7
Lincoln => 7
Martone => 7
Davis => 7
Apricot Valley => 7
Bret Harte => 7
Northmead => 7
French Camp => 7
Hanshaw => 7
Our Lady Of Fatima => 7
Bret Harte => 7
Martone => 7
Central => 7
Apricot Valley => 7
Orchard => 7
Julien => 7
Earle Williams => 7
DOC
  assign.split("\n").uniq.each do |line|
    school = School.find_by_title(line.split(" => ")[0])
    type_id = line.split(" => ")[1]
    unless school.nil?
      school.package_types.push(PackageType.find(type_id.to_i))
      puts "NO SAVE" unless school.save
    else
      puts "SCHOOL: '#{line}' COULD NOT BE FOUND"
    end
  end
end