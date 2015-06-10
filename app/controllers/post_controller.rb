class PostController < ApplicationController
	def getPostId

		return json: Post.getPostById(Params)

	end

end
