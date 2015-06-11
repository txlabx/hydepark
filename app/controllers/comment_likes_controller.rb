class CommentLikesController < ApplicationController

	def likeComment
			render json: CommentLike.likeComment(params)
	end

end
