require 'csv'    
PROJECT_NAMES = []
CSV.foreach("colors3.csv", :headers => false) do |row|
  PROJECT_NAMES << row[0]
end

PROJECT_NAMES.each do |n|
	n.gsub!(";",'')
end

CSV.open("colors4.csv", "wb") do |csv|
	PROJECT_NAMES.count.times do
		color = PROJECT_NAMES[rand(PROJECT_NAMES.count)]
		csv << [color]
		PROJECT_NAMES.delete(color)
	end
end