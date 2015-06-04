class User < ActiveRecord::Base
	#include GeneralFunctions
	def self.signInUser(params)
		
		begin
			email = params.fetch(:email)
			password = params.fetch(:password)
			#user_exists = User.where(email: email, password: password)
			user_exists=User.where("email = ? AND password = ?", params[:email], params[:password]).first


			if user_exists

	   			id=user_exists[:id]
	   			u=User.find(id)
	   			u.last_login=Time.now.to_i
	   			
	   			if(u.save)
	   					return {"success"=>1, "message"=>"user is successfully Logged In", "userProfile"=>getProfile(user_exists)}
	   			else
	   					return {"success"=>0, "message"=>"database error"}
				end
			else

				return {"success"=>0, "message"=>"email address or password is incorrect"}
			end 
				
		rescue Exception => e
		   
		   	return {'status'=>'failure', 'message'=>e.message}
		
		end	 
		
	end
	#-----------------------------------------------------------------------------------------------
	def self.getProfile(user)
		
	    user_id = General.validate_session_token(user);

		if(user[:profile_type] == 'IMAGE')
			user[:profile_link] = "#{ENV['IMAGE_PATH']}#{user[:profile_link]}"
		elsif(user[:profile_type] == 'VIDEO')
			user[:profile_link] = "#{ENV['VIDEO_PATH']}#{user[:profile_link]}"
		end

		if(user[:cover_type] == 'IMAGE')
			user[:cover_link] = "#{ENV['IMAGE_PATH']}#{user[:cover_link]}"
		elsif(user[:cover_type] == 'VIDEO')
			user[:cover_link] = "#{ENV['VIDEO_PATH']}#{user[:cover_link]}"
		end
 		user = user.as_json 
		user.delete('password')
		return user_id	
	end

end
