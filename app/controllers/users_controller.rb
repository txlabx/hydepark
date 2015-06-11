class UsersController < ApplicationController

	def userSignUp
		render json: User.registerUser(params)
	end

	def userLogin
		render json: User.userSignIn(params)
	end

	def updateProfile
		render json: User.updateProfile(params)
	end
end
