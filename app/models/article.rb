class Article
  include Mongoid::Document

  field :nr, :type => Integer
  field :site
  embeds_many :images

  def self.latest_nr(site)
    Article.where(:site => site).order_by([:nr,:desc]).first.try(:nr) || 0
  end
end
