require 'rubygems'
require 'hpricot'
require 'open-uri'

rss = open("http://oglaf.com/feeds/rss/") { |f| Hpricot(f) }
articles = (rss / 'item guid').map(&:inner_text)

# for now, just run one
article = articles[-1]

finished = false
nr = 1
while !finished
  begin
    article_doc = open("#{article}#{nr}") { |f| Hpricot(f) }
    p article_doc / '#strip'
    nr += 1
  rescue OpenURI::HTTPError => e
    finished = true
  end
end
