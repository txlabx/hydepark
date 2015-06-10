class UsersController < ApplicationController

	def userSignUp
		render json: User.registerUser(params)
	end

	def userLogin
		render json: User.userSignIn(params)
	end
end
