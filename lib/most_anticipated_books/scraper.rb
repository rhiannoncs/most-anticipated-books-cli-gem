class MostAnticipatedBooks::Scraper

	def self.scrape_millions(url)
		doc = Nokogiri::HTML(open(url))

		amazon_link = doc.css("p > em:nth-child(2) a")
		amazon_link_2 = doc.css("p > a:nth-child(2)")
		amazon_link_3 = doc.css("p > i:nth-child(2) a")

		start = "translated by[[:space:]]"
		finish = Regexp.escape(')')

		doc.css("p").each do |paragraph|
			matches = paragraph.css("a[href]") & amazon_link
			matches_2 = paragraph.css("a[href]") & amazon_link_2
			matches_3 = paragraph.css("a[href]") & amazon_link_3
			if matches.length > 0
				book = MostAnticipatedBooks::Book.new(matches.text)
				book.amazon_url = matches[0]["href"]
				book.description = paragraph.text
				if book.description.include?("translated by")
					book.translator = book.description[/#{start}(.*?)#{finish}/m, 1]
				end
			end
			if matches_2.length > 0
				book = MostAnticipatedBooks::Book.new(matches_2.text)
				book.amazon_url = matches_2[0]["href"]
				book.description = paragraph.text
				if book.description.include?("translated by")
					book.translator = book.description[/#{start}(.*?)#{finish}/m, 1]
				end
			end
			if matches_3.length > 0
				book = MostAnticipatedBooks::Book.new(matches_3.text)
				book.amazon_url = matches_3[0]["href"]
				book.description = paragraph.text
				if book.description.include?("translated by")
					book.translator = book.description[/#{start}(.*?)#{finish}/m, 1]
				end
			end
		end
		
		MostAnticipatedBooks::Book.all.each do |book|
			puts book.title + "/" + book.amazon_url + "/" + book.description
			puts book.translator if book.translator
		end
	end

end