class MostAnticipatedBooks::Genre
  attr_accessor :name
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
    @books = []
  end
  
  def self.all
    @@all
  end
  
  def add_book(book)
    @books << book
  end
  
  def books
    @books
  end
  
  def book_count
    @books.size
  end
  
  def self.genres_with_count
    @@all.each {|genre| puts "#{genre.name}: #{genre.book_count}"}
  end
  
end