require 'open-uri'
require 'nokogiri'
require 'sinatra'

helpers do
  def get_poem_title(url) # Gets the title of a given poem using the CSS selector
    poem_title = Nokogiri::HTML(open(url)).css("#page-title")
    poem_title
  end

  def get_poem_author(url) # Gets the author of a given poem using the CSS selector
    poem_author = Nokogiri::HTML(open(url)).css(".poet-name-in-poem")
    poem_author
  end

  def get_poem_text(url) # Gets the text of the poem, to be iterated over using a block in the view
    poem_text = Nokogiri::HTML(open(url)).css(".line-text")
    poem_text
  end

  def get_random_poem # Gets a random poem from the RPO library of poems
    url = "http://rpo.library.utoronto.ca/poems"
    poem_url = "http://rpo.library.utoronto.ca" + Nokogiri::HTML(open(url)).css("#block-system-main a")[rand(1..4785)]["href"]
    poem_url
  end
end

get '/' do
  erb :index
end

get '/poem' do
  @poem_url = get_random_poem
  @poem_title = get_poem_title(@poem_url)
  @poem_author = get_poem_author(@poem_url)
  @poem_text = get_poem_text(@poem_url)
  erb :poem
end