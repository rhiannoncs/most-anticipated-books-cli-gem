class MostAnticipatedBooks::CLI
	def call
		puts "Welcome! Let's explore the Most Anticipated Books for the first half of 2018."
		
		input = menu

		case input
		when "1"
			list_all
		when "2"
			puts "Which month would you like to explore?"
			month_input = gets.strip
			MostAnticipatedBooks::Book.books_by_month(month_input)
		when "3"
			MostAnticipatedBooks::Genre.list_all
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
	end

	def list_all
		MostAnticipatedBooks::Book.list_all
			
		number_selection = nil
		until (1..MostAnticipatedBooks::Book.all.length + 1).include?(number_selection) do
			puts "To see more information about a title, enter its number."
			number_selection = gets.to_i
		end
		MostAnticipatedBooks::Book.book_by_number(number_selection)
			
		secondary_input = nil
		until ["menu", "exit"].include?(secondary_input) do
			puts "If you would like to see the menu for more options, type 'menu.' To exit, type 'exit.'"
			secondary_input = gets.downcase.strip
		end

		case secondary_input
		when "menu"
			menu
		when "exit"
			exit
		end	
	end	
end