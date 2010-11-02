class Article
  include Mongoid::Document

  field :nr, :type => Integer
  field :image_url
  field :alt_text

  def self.latest_nr
    Article.order_by([:nr,:desc]).first.try(:nr) || 0
  end
end
