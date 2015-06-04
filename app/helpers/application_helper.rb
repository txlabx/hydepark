module ApplicationHelper
	
	def self.validate_session_token(user)


		result=User.where("session_token = ? ", user[:session_token]).first
		if result
			time=Time.now.to_i - result[:last_login]
			
			if time > ENV['SESSION_EXPIRES_SECONDS'].to_i
				return -1
				#return {"status"=>"failure" , "message"=>"session has been expired please login" }
			else
				return result[:id]
				#return {"status"=>"success" , "message"=>"you are successfully logged in" , "userId"=>result[:id] }
			end

		else
			return -1
			#return {"status"=>"failure" , "message"=>"Incorrect session token"  }

		end

	end
	

	
end
