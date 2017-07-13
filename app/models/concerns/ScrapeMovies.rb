require 'open-uri'
class MovieScraper
  attr_reader :zip

  def initialize(zip = "10001")
    @zip = zip
  end

  def run
    new_movies = []
    url = "https://www.fandango.com/#{@zip.to_i}_movietimes" if @zip.length == 5
    html = Nokogiri::HTML(open(url))
    html.css("a.showtimes-movie-title").each{ |movie_title| new_movies << movie_title.text }
    new_movies.uniq.each{ |name| Movie.find_or_create_by(name: name) }
  end
end
