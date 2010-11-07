class Image
  include Mongoid::Document

  field :image_url
  field :alt_text
  field :origin_url
  embedded_in :articles, :inverse_of => :images

end
