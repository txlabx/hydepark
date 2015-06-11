class Topic < ActiveRecord::Base
has_many :posts
	

	#----------------------------------------------------------------------------------------------------------
	#                                 Validate Session Token from "users" Table
	#----------------------------------------------------------------------------------------------------------

	def self.validate_session_token(session_token)
		
		begin
			user = User.where(session_token: session_token).first
			if(user.blank?)
				return {"success"=>0,"message"=> "Session_Token is Not Correct."}
			else
				return user
			end

		rescue Exception => e
		
			return {"success"=>0, 'message'=>e.message}
		end
	end

	
	#----------------------------------------------------------------------------------------------------------
	#                                 Get All Topics From "topics" Table 
	#----------------------------------------------------------------------------------------------------------
	def self.getTopics(params)
		
			begin
				
				params.require(:session_token)

				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end	

				qeury=Topic.select("id, name, concat('#{ENV['IMAGE_PATH']}',image) AS image")
				if(qeury.blank?)

					return {'success'=>0,'message'=>"No topic found."}
				else
					return {'success'=>1,'topics'=>qeury}

				end
			rescue Exception => e
		  
		  		return {'success'=>0, 'message'=>e.message}
		
			end
	end

#-------------------------------------------------------------------------------------------------------------	

end
#----------------------------------------------------------------------------------------------------------
#                                     End Of Topic Module
#-------------------------------------------------------------------------------------------------------------