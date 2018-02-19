class MostAnticipatedBooks::Scraper

	def self.scrape_millions(url)
		doc = Nokogiri::HTML(open(url))

		amazon_link = doc.css("p > em:nth-child(2) a")
		amazon_link_2 = doc.css("p > a:nth-child(2)")
		amazon_link_3 = doc.css("p > i:nth-child(2) a")

		doc.css("p").each do |paragraph|
			matches = paragraph.css("a[href]") & amazon_link
			matches_2 = paragraph.css("a[href]") & amazon_link_2
			matches_3 = paragraph.css("a[href]") & amazon_link_3
			if matches.length > 0
				book = MostAnticipatedBooks::Book.new(matches.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, ''))
				book.amazon_url = matches[0]["href"]
				description_author_translator(paragraph, book)
			end
			if matches_2.length > 0
				book = MostAnticipatedBooks::Book.new(matches_2.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, ''))
				book.amazon_url = matches_2[0]["href"]
				description_author_translator(paragraph, book)
			end
			if matches_3.length > 0
				book = MostAnticipatedBooks::Book.new(matches_3.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, ''))
				book.amazon_url = matches_3[0]["href"]
				description_author_translator(paragraph, book)
			end
		end
	end

	def self.description_author_translator(paragraph, book)
		start = "translated by[[:space:]]"
		finish = Regexp.escape(')')

		book.description = paragraph.text
		book.author = paragraph.css("strong")[0].text.delete(":").strip
		if book.description.include?("translated by")
			book.translator = book.description[/#{start}(.*?)#{finish}/m, 1]
		end
	end

	def self.scrape_amazon(book)
		user_agent = 'Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3'
		doc = Nokogiri::HTML(open(book.amazon_url, 'User-Agent' => user_agent))

		publication_date = doc.css("div#booksTitle > div.a-section.a-spacing-none > h1#title > span:nth-child(3)").text
		publication_date.length == 0 ? book.publication_date = "Unknown" : book.publication_date = publication_date.delete("–").strip

		genre = doc.css("ul.zg_hrsr > li.zg_hrsr_item > span.zg_hrsr_ladder > a:nth-child(2)")[0]
		genre.nil? ? book.genre = "Unknown" : book.genre = genre.text

		isbn = doc.at_css('li:contains("ISBN-10")')
		isbn.nil? ? book.isbn = "Unknown" : book.isbn = isbn.text.sub("ISBN-10: ", '')
		
		start = "Publisher:[[:space:]]"
		finish = Regexp.escape('(')
		publisher = doc.at_css('li:contains("Publisher")')
		publisher ? book.publisher = publisher.text[/#{start}(.*?)[[:space:]]#{finish}/m, 1] : book.publisher = "Unknown"
		

		book.subgenres = []
		subgenres = doc.css("ul.zg_hrsr > li.zg_hrsr_item > span.zg_hrsr_ladder > a")
		
		if subgenres.text.length > 0
			subgenres.each do |genre|
				book.subgenres << genre.text unless genre.text == "Books" || book.subgenres.include?(genre.text) || book.genre.name == genre.text
			end
		else 
			book.subgenres << "Unknown"
		end
		final_subgenres = doc.css("ul.zg_hrsr > li.zg_hrsr_item > span.zg_hrsr_ladder > b > a")
		
		if final_subgenres.text.length > 0
			final_subgenres.each do |genre|
				book.subgenres << genre.text unless genre.text == "Books" || book.subgenres.include?(genre.text) || book.genre.name == genre.text
			end
		else
			book.subgenres << "Unknown" unless book.subgenres.include?("Unknown")
		end

		puts "#{book.title} updated"
	end

end