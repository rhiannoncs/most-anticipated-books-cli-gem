class MostAnticipatedBooks::CLI
	def call
		puts "Welcome! Let's explore the Most Anticipated Books for the first half of 2018."
		
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
			MostAnticipatedBooks::Author.list_all
		when "5"
			MostAnticipatedBooks::Book.translated_books
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
		until (1..book_array.length + 1).include?(number_selection) do
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

		genre_input = nil
		until MostAnticipatedBooks::Genre.lowercase_all.include?(genre_input) do
			puts "To see a list of books within a genre, enter the genre."
			genre_input = gets.downcase.strip
		end

		genre_books = MostAnticipatedBooks::Book.books_by_genre(genre_input)

		detail_view(genre_books)

		follow_up
	end	
end