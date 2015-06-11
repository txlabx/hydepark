class PostSeensController < ApplicationController
	def postSeen
			render json: PostSeen.postViews(params)
	end

end
