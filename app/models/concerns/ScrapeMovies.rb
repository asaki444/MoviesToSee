require 'open-uri'
class Scraper
  attr_accessor :url, :arr
  attr_reader :zip
  @@all = []
  def initialize(zip = "10001")
    @zip = zip
    @@all << self
  end

  def all
    @@all
  end

  def doc
    @arr = []
    @url = "https://www.fandango.com/#{@zip.to_i}_movietimes" if @zip.length == 5
    @html = Nokogiri::HTML(open(@url))
    @html.css("a.showtimes-movie-title").each{ |x| @arr << x.text}
    @arr.uniq.each{|x| Movie.create(name: x) }
  end
end
