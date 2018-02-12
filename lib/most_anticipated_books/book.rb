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

end