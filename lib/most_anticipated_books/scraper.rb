class MostAnticipatedBooks::Scraper

	def self.scrape_millions(url)
		doc = Nokogiri::HTML(open(url))

		amazon_link = doc.css("a")

		puts amazon_link
	end

end