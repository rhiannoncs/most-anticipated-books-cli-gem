class MostAnticipatedBooks::Scraper

	def self.scrape_millions(url)
		doc = Nokogiri::HTML(open(url))

		amazon_link = doc.css("p > em:nth-child(2) a")
		amazon_link_2 = doc.css("p > a:nth-child(2)")
		amazon_link_3 = doc.css("p > i:nth-child(2) a")

		author = doc.css("p > em + strong:nth-child(3)") #matches links and titles from amazon_link
		author_2 = doc.css("p > a + strong:nth-child(3)") #misses Lynne Tillman, Clarice Lyspector, etc.
		

		puts author_2
	end

end