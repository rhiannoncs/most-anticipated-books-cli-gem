class MostAnticipatedBooks::Translator
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
end