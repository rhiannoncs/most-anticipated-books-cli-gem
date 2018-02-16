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

	def self.list_all
		all.each_with_index {|book, index| puts "#{index + 1}. #{book.title} by #{book.author.name}"}
	end

	def self.books_by_month(month)
		month_books = all.select{|book| book.publication_date.include?(month)}
  		month_books.each_with_index {|book, index| puts "#{index + 1}. #{book.title} by #{book.author.name}"}
  		month_books
  	end

  def self.book_by_number(book_array, number_input)
  	book_array.each_with_index {|book, index| book.display_info if index == number_input - 1}
  end

  def display_info
    puts "*******"
    puts "#{self.title} by #{self.author.name}"
    puts "Translated by #{self.translator.name}" if self.translator
    puts "Publication Date: #{self.publication_date}"
    puts "Genres: #{self.genre.name}, #{self.subgenres.join(", ")}"
    puts "Publisher: #{self.publisher}, ISBN: #{self.isbn}"
    puts "----------"
    puts self.description
    puts "*******"
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
  
  def self.books_by_genre(number_input)
    genre = MostAnticipatedBooks::Genre.all[number_input - 1]
    genre_books = all.select{|book| book.genre == genre}
  	genre_books.each_with_index {|book, index| puts "#{index + 1}. #{book.title} by #{book.author.name}"}
  	genre_books
  end

  def self.books_by_author(number_input)
    author = MostAnticipatedBooks::Author.all[number_input - 1]
  	all.each {|book| book.display_info if book.author == author}
  end	

  def self.translated_books
  	translated_books = all.select{|book| book.translator}
  	translated_books.each_with_index {|book, index| puts "#{index + 1}. #{book.title} by #{book.author.name}"}
  	translated_books
  end
end