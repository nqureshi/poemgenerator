require 'open-uri'
require 'nokogiri'
require 'sinatra'

URL = "http://rpo.library.utoronto.ca/poems"

helpers do
  def get_random_poem # Gets a random poem from the RPO library of poems
    poem_url = Nokogiri::HTML(open(URL)).css("#block-system-main a")[rand(1..4785)]["href"]
    URL.gsub("/poems", "") + poem_url
  end
end

before do
  pass if request.path_info == "/"
  @poem = Nokogiri::HTML(open(get_random_poem))
  @poem_title = @poem.css("#page-title")
  @poem_author = @poem.css(".poet-name-in-poem")
  @poem_text = @poem.css(".line-text")
end

get '/' do
  erb :index
end

get '/poem' do
  erb :poem
end