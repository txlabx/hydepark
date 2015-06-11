class PostsController < ApplicationController

	def getPostById
			render json: Post.postById(params)
	end

	def getContentByTopic
			render json: Post.contentByTopic(params)
	end

	def getHomeContent
			render json: Post.homeContent(params)
	end
	def getUserPost
			render json: Post.userPost(params)
	end
	def uploadStatus
			render json: Post.uploadStatus(params)
	end
	def getUserBeam
			render json: Post.userBeam(params)
	end
	def getMyChannel
			render json: Post.myChannel(params)
	end
<<<<<<< HEAD
	def getMyChannel
			render json: Post.myChannel(params)
	end
	def getTrendingVideos
		render json: Post.trendingVideos(params)
	end
	


=======
>>>>>>> d0b6b13e89368c5e0cc92f28befc0e85c62d04f9


end
