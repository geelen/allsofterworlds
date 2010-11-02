class Article
  include Mongoid::Document

  field :nr, :type => Integer
  field :image_url
  field :alt_text
end
