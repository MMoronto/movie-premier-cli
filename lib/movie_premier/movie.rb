class MoviePremier::Movie
  attr_accessor :name, :url, :summary, :stars
  
  @@all = []
  
  #def self.new_from_index_page(r)
  #self.new(
      #r.css("h2").text,
      #"https://www.imdb.com#{r.css("a").attribute("href").text}",
      #r.css("h3").text,
      #r.css(".position").text
      #)
  #end 

  def initialize(name = nil, url = nil, summary = nil, stars = nil)
    @name = name
    @url = url
    @summary = summary 
    @stars = stars
    @@all << self
  end

  def self.all
    @@all 
  end

  def self.find(id)
    self.all[id-1]
  end

  def name 
    @name ||= doc.css("h4 a.").text 
  end
  
  def url 
    @url ||= doc.css("https://www.imdb.com/movies-coming-soon/").text 
  end 
  
  def summary
    @summary ||= doc.css("div.outline").text
  end

  def stars
    @stars ||= doc.css("#titleCast span[itemprop='name']").collect{|e| e.text.strip}.join(", ")
  end

  def self.scrape_movie_premier
    doc = Nokogiri::HTML(open('https://www.imdb.com/movies-coming-soon/'))
    #binding.pry 
    names = doc.search("h3[itemprop='name'] a[itemprop='url']")
    names.collect{|e| new(e.text.strip, "http://imdb.com#{e.attr("href").split("?").first.strip}")}
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end
  
end 
