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
  
  #def self.find_by_name(name)
    #self.all.detect do |m|
      #m.name.downcase.strip == name.downcase.strip ||
      #m.name.split("(").first.strip.downcase == name.downcase.strip
    #end
  #end

  def name 
    @name ||= doc.search("td.overview-top h4 a").text 
  end
  
  def url 
    @url ||= doc.css("td.overview-top h4 a").attribute('href').value 
  end 
  
  def summary
    @summary ||= doc.search("td.overview-top div.outline").text
  end

  def stars
    @stars ||= doc.search("h5.inline[itemprop='name'] a[itemprop='url']").attribute('href').value.collect{|e| e.text.strip}.join(", ")
  end

  def self.scrape_movie_premier
    doc = Nokogiri::HTML(open('https://www.imdb.com/movies-coming-soon/'))
    binding.pry 
    names = doc.search("h5.inline #Stars[itemprop='name'] a[itemprop='url']")
    names.collect{|e| new(e.text.strip, "http://imdb.com#{e.attr("href").split("?").first.strip}")}
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end
  
end 
