class MostAnticipatedBooks::CLI
	def call
		puts "Welcome! Let's explore the Most Anticipated Books for the first half of 2018."
		menu
	end

	def menu
		puts "What would you like to do?"
		puts "1. Explore the whole list of Most Anticipated Books."
		puts "2. Explore books set to be published in a certain month."
		puts "3. Explore represented genres."
		puts "4. Explore the books' authors."
		puts "5. Explore books in translation."
		puts "Please choose by number, 1-5."
	end
end