class MostAnticipatedBooks::Author
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

  def self.list_all
    @@all.each_with_index {|author, index| puts "#{index + 1}. #{author.name}"}
  end
  
  def add_book(book)
    @books << book
  end
  
  def books
    @books
  end
end