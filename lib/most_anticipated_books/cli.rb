class MostAnticipatedBooks::CLI

	def call
		puts "Welcome! Let's explore the Most Anticipated Books for the first half of 2018."
		puts "Loading book data. Please be patient - this might take a little while."

		MostAnticipatedBooks::Scraper.scrape_millions("https://themillions.com/2018/01/most-anticipated-the-great-2018-book-preview.html")
		MostAnticipatedBooks::Book.all.each {|book| MostAnticipatedBooks::Scraper.scrape_amazon(book)}
		
		explore_menu
	end

	def explore_menu
		input = menu

		case input
		when "1"
			list_all
		when "2"
			list_by_month
		when "3"
			list_by_genre
		when "4"
			list_by_author
		when "5"
			list_in_translation
		when "exit"
			exit
		end
	end

	def menu
		input = nil
		until ["1", "2", "3", "4", "5", "exit"].include?(input) do
			
			puts "What would you like to do?"
			puts "1. Explore the whole list of Most Anticipated Books."
			puts "2. Explore books set to be published in a certain month."
			puts "3. Explore represented genres."
			puts "4. Explore the books' authors."
			puts "5. Explore books in translation."
			puts "Please choose by number, 1-5. To exit, type 'exit.'"

			input = gets.downcase.strip
		end
		input
	end

	def list_all
		MostAnticipatedBooks::Book.list_all
			
		detail_view(MostAnticipatedBooks::Book.all)
			
		follow_up
	end

	def detail_view(book_array)
		number_selection = nil
		until (1..book_array.length).include?(number_selection) do
			puts "To see more information about a title, enter its number."
			number_selection = gets.to_i
		end
		MostAnticipatedBooks::Book.book_by_number(book_array, number_selection)
	end

	def follow_up
		secondary_input = nil
		until ["menu", "exit"].include?(secondary_input) do
			puts "If you would like to see the menu for more options, type 'menu.' To exit, type 'exit.'"
			secondary_input = gets.downcase.strip
		end

		case secondary_input
		when "menu"
			explore_menu
		when "exit"
			exit
		end
	end	

	def list_by_month
		month_input = nil
		until ["January", "February", "March", "April", "May", "June"].include?(month_input) do
			puts "Which month would you like to explore (January-June)?"
			month_input = gets.capitalize.strip
		end
		month_books = MostAnticipatedBooks::Book.books_by_month(month_input)

		detail_view(month_books)

		follow_up
	end

	def list_by_genre
		MostAnticipatedBooks::Genre.genres_with_count

		number_input = nil
		until (1..MostAnticipatedBooks::Genre.all.length).include?(number_input) do
			puts "To see a list of books within a genre, enter its number."
			number_input = gets.to_i
		end

		genre_books = MostAnticipatedBooks::Book.books_by_genre(number_input)

		detail_view(genre_books)

		follow_up
	end

	def list_by_author
		MostAnticipatedBooks::Author.list_all

		number_input = nil
		until (1..MostAnticipatedBooks::Author.all.length).include?(number_input) do
			puts "To see information about an author's book(s), enter the author's number."
			number_input = gets.to_i
		end	

		MostAnticipatedBooks::Book.books_by_author(number_input)

		follow_up
	end

	def list_in_translation
		translated_books = MostAnticipatedBooks::Book.translated_books

		detail_view(translated_books)

		follow_up
	end	
end