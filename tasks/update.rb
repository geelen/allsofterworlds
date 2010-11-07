namespace :update do
  task :requires do
    # We need to pull in some packages first
    require 'open-uri' # for downloading a web page
    require 'hpricot' # for grabbing information out of a web page
    require 'app/env.rb' # our connection to the db
  end

  desc "A Softer World"
  task :asofterworlds => :requires do
    # We fetch the home page to find out what the latest article is
    doc = open("http://asofterworld.com/") { |f| Hpricot(f) }
    title = (doc / 'title').inner_text
    newest = title.split(' ').last.to_i
    if newest.nil? || newest == 0
      raise "Something went wrong! The title of #{title.inspect} was parsed into an article number of #{newest.inspect}"
    end
    puts "Newest article online is #{newest}"

    # Find the highest-numbered article we've already got
    latest_already_processed = Article.latest_nr
    puts "The latest article we have is #{latest_already_processed}"
    puts ""

    (latest_already_processed + 1).upto(newest) do |nr|
      puts "Fetching article #{nr}:"
      # Grab the HTML
      original_url = "http://asofterworld.com/index.php?id=#{nr}"
      article_doc = open() { |f| Hpricot(f) }
      # Extract the image element
      img = article_doc / '.rss-content img:first'
      # Get the image source
      image_url = img.attr('src')
      puts "  Image: #{image_url}"
      # Get the alt text
      alt_text = img.attr('title')
      puts "  Alt Text: #{alt_text}"
      # Store the result
      Article.create!(:nr => nr, :site => Sites::SOFTER_WORLD,
                      :images => [Image.new(:image_url => "http://asofterworld.com/#{image_url}",
                                            :alt_text => alt_text,
                                            :original_url => original_url)])
    end
  end

  desc "Oglaf"
  task :oglaf => :requires do
    Article.delete_all

    rss = open("http://oglaf.com/feeds/rss/") { |f| Hpricot(f) }
    articles = (rss / 'item guid').map(&:inner_text).reverse

    # for now, just run the very first one
    nr = 0
    article_url = articles[nr]
    name = article_url.split('/').last
    puts "Processing article nr #{nr + 1}: #{name}"

    finished = false
    images = []
    while !finished
      begin
        original_url = "#{article_url}#{images.length + 1}"
        article_doc = open(original_url) { |f| Hpricot(f) }
        img = article_doc / '#strip'
        images << Image.new(:image_url => "http://oglaf.com/#{img.attr('src')}",
                            :alt_text => img.attr('title'),
                            :original_url => original_url)
      rescue OpenURI::HTTPError => e
        finished = true
      end
    end

    puts "  Found #{images.length} images"
    Article.create!(:nr => nr + 1, :site => Sites::OGLAF, :images => images)
  end
end
