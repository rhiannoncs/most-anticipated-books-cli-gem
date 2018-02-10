class MostAnticipatedBooks::Scraper

	def self.scrape_millions(url)
		doc = Nokogiri::HTML(open(url))

		title_array = []

		amazon_link = doc.css("p > em:nth-child(2) a")
		amazon_link_2 = doc.css("p > a:nth-child(2)")
		amazon_link_3 = doc.css("p > i:nth-child(2) a")

		#author = doc.css("p > em + strong:nth-child(3)") #matches links and titles from amazon_link
		#author_2 = doc.css("p > a + strong:nth-child(3)") #misses Lynne Tillman, Clarice Lyspector, etc.
		

		doc.css("p").each do |paragraph|
			matches = paragraph.css("a[href]") & amazon_link
			matches_2 = paragraph.css("a[href]") & amazon_link_2
			matches_3 = paragraph.css("a[href]") & amazon_link_3
			if matches.length > 0
				title_array << {:title => matches.text, :amazon_url => matches[0]["href"]}
			end
			if matches_2.length > 0
				title_array << {:title => matches_2.text, :amazon_url => matches_2[0]["href"]}
			end
			if matches_3.length > 0
				title_array << {:title => matches_3.text, :amazon_url => matches_3[0]["href"]}
			end
		end
		
		puts title_array
	end

end