class Post < ActiveRecord::Base
has_many :post_likes
has_many :post_seens
has_many :comments
has_many :tags
belongs_to :topic

	

end
