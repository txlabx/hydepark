class Comment < ActiveRecord::Base
belongs_to :post
has_many :comment_likes
end
