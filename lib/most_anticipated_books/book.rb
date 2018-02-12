class MostAnticipatedBooks::Book
	attr_accessor :title, :author, :translator, :amazon_url, :publication_date, :genre, :subgenres, :description, :isbn, :publisher

	def initialize(title)
		@title = title
	end

end