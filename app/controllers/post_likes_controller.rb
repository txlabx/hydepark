class PostLikesController < ApplicationController

	def postLike
			render json: PostLike.postLike(params)
	end

end
