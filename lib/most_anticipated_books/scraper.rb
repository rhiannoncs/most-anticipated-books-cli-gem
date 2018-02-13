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
				book = MostAnticipatedBooks::Book.new(matches.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, ''))
				book.amazon_url = matches[0]["href"]
				book.description = paragraph.text
				book.author = paragraph.css("strong")[0].text.delete(":")
				if book.description.include?("translated by")
					book.translator = book.description[/#{start}(.*?)#{finish}/m, 1]
				end
			end
			if matches_2.length > 0
				book = MostAnticipatedBooks::Book.new(matches_2.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, ''))
				book.amazon_url = matches_2[0]["href"]
				book.description = paragraph.text
				book.author = paragraph.css("strong")[0].text.delete(":")
				if book.description.include?("translated by")
					book.translator = book.description[/#{start}(.*?)#{finish}/m, 1]
				end
			end
			if matches_3.length > 0
				book = MostAnticipatedBooks::Book.new(matches_3.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, ''))
				book.amazon_url = matches_3[0]["href"]
				book.description = paragraph.text
				book.author = paragraph.css("strong")[0].text.delete(":")
				if book.description.include?("translated by")
					book.translator = book.description[/#{start}(.*?)#{finish}/m, 1]
				end
			end
		end
		
		MostAnticipatedBooks::Book.all.each do |book|
			puts book.title + "/" + book.author if book.author
			#puts book.translator if book.translator
		end
	end

	def self.scrape_amazon(book)
		doc = Nokogiri::HTML(open(book.amazon_url))

		book.publication_date = doc.css("div#booksTitle > div.a-section.a-spacing-none > h1#title > span:nth-child(3)").text.delete("–").strip
		book.genre = doc.css("ul.zg_hrsr > li.zg_hrsr_item > span.zg_hrsr_ladder > a:nth-child(2)")[0].text
		
		puts book.publication_date
		puts book.genre
	end

end