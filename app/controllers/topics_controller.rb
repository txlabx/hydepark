class TopicsController < ApplicationController

	def getAllTopics
			render json: Topic.getTopics(params)
	end
end
