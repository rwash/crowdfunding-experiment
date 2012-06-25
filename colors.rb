require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_colors"))

colors = doc.xpath("//tr//th//a")
File.open("colors.csv", 'w') do |f|

	colors.each do |node|
		f.write( node.inner_text )
		f.write(";\n")
	end
end