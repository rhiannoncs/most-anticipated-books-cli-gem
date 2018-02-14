class MostAnticipatedBooks::Book
	attr_accessor :title, :author, :translator, :amazon_url, :publication_date, :genre, :subgenres, :description, :isbn, :publisher
	@@all = []
	
	def initialize(title)
		@title = title
		@@all << self
	end

	def self.all
		@@all
	end

	def self.books_by_month(month)
  		@@all.each {|book| book.display_info if book.publication_date.include?(month)}
  	end

  	def display_info
    	puts "*******"
    	puts "#{self.title} by #{self.author.name}"
    	puts "Translated by #{self.translator}" if self.translator
    	puts "Publication Date: #{self.publication_date}"
    	puts "Genre: #{self.genre.name}"
    	puts "Subgenres: #{self.subgenres.join(", ")}"
    	puts "Publisher: #{self.publisher}, ISBN: #{self.isbn}"
    	puts "----------"
    	puts self.description
    end

    def genre=(genre_name)
    	selected_genre = MostAnticipatedBooks::Genre.all.find {|genre| genre.name == genre_name}
    	if selected_genre
      		@genre = selected_genre
    	else
      		new_genre = MostAnticipatedBooks::Genre.new(genre_name)
      		@genre = new_genre
    	end
    	selected_genre = MostAnticipatedBooks::Genre.all.find {|genre| genre.name == genre_name}
    	selected_genre.add_book(self) unless selected_genre.books.include?(self)
  	end
  
  	def author=(author_name)
    	if MostAnticipatedBooks::Author.all.find {|author| author.name == author_name}
      		@author = author
    	else
      		new_author = MostAnticipatedBooks::Author.new(author_name)
      		@author = new_author
    	end
    	selected_author = MostAnticipatedBooks::Author.all.find {|author| author.name == author_name}
    	selected_author.add_book(self) unless selected_author.books.include?(self)
  	end

  	def translator=(translator_name)
    	if MostAnticipatedBooks::Translator.all.find {|translator| translator.name == translator_name}
      		@translator = translator
    	else
      		new_translator = MostAnticipatedBooks::Translator.new(translator_name)
      		@translator = new_translator
    	end
    	selected_translator = MostAnticipatedBooks::Translator.all.find {|translator| translator.name == translator_name}
    	selected_translator.add_book(self) unless selected_translator.books.include?(self)
  	end
  
  	def self.books_by_genre(genre_name)
    	all.each {|book| puts book.title if book.genre.name == genre_name}
  	end

  	def self.translated_books
  		all.each {|book| puts book.title if book.translator}
  	end
end