class FriendsController < ApplicationController

	def deleteFriend
			render json: Friend.deleteFriend(params)
	
	end
	def acceptFriendRequest
			render json: Friend.acceptRequest(params)
	end
	def sendFriendRequest
			render json: Friend.sendRequest(params)
	end
	def deleteFriendRequest
			render json: Friend.deleteRequest(params)
	end
	def searchFriends
			render json: Friend.searchFriend(params)
	end
end
