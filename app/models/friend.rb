class Friend < ActiveRecord::Base

	#----------------------------------------------------------------------------------------------------------
	#                                 Validate Session Token From "users" Table 
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
	#        Accept request of Friend and Change 'state' from 'PENDING' to 'FRIEND' in "friends" Table 
	#----------------------------------------------------------------------------------------------------------
	def self.acceptRequest(params)
		begin
				params.require(:friend_id)
				params.require(:session_token)

				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end

				qeury=User.where(id: params[:friend_id]) 
				if(qeury.blank?)
						return {"success"=>0, 'message'=>'This friend_id does not belong to any user.'}
				end

			    qeury1=Friend.where("user_id = ? AND friend_id = ?",params[:friend_id],user[:id]).first
				if(qeury1.blank?)
						return {"success"=>0, 'message'=>'This user has not sent you friend request.'}
				else
					if(qeury1[:state]=='PENDING')
						
						qeury3=Friend.where("user_id = ? AND friend_id = ?",params[:friend_id],user[:id])
						.update_all(:state => "FRIEND")
						
						if(qeury3.blank?)
							return {"succes"=>0 , "message"=>"DB operation failed"}
						else
							return {"success"=>1, "message"=>"Friend Request Successfully Accepted."}
						end
					
					elsif (qeury1[:state]=='FRIEND')

						return {"success"=>0, 'message'=>'This user is already in your friend list.'}

					end
				end
		rescue Exception => e
			return {"success"=>0, 'message'=>e.message}
		end

	end

	#----------------------------------------------------------------------------------------------------------
	#          			              Deleting Friend From "friends" Table 
	#-------------------------------------------------------------------------------------------------------------
	def self.deleteFriend(params)

		begin
			params.require(:session_token)
			params.require(:friend_id)

			session_token = params.fetch(:session_token)
			user= validate_session_token(session_token)

			if(!user)
					return {"success"=>0, 'message'=>'Invalid session_token.'}
			end

			qeury=Friend.where("(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)", user[:id], params[:friend_id],params[:friend_id],user[:id])
			.destroy_all

			if(qeury.blank?)
				return {"success"=>0 , 'message'=>"User is not Friend with the given Friend_Id." }
			else
				return {"success"=>1 , 'message'=> "Deletion Successfull."}
			end

		rescue Exception => e
				return {"success"=>0, 'message'=>e.message}
		end

	end

	
	#----------------------------------------------------------------------------------------------------------
	#          Sending a Friend Request and inserting a row "friends" Table with 'state' = 'PENDING'
	#--------------------------------------------------------------------------------------------------------


	def self.sendRequest(params)
		begin
				params.require(:friend_id)
				params.require(:session_token)

				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end

				qeury=User.where(id: params[:friend_id]) 
				
				if(qeury.blank?)
						
						return {"success"=>0, 'message'=>'This friend_id does not belong to any user.'}
				end
				
				qeury1=Friend.where("user_id = ? AND friend_id = ?",user[:id],params[:friend_id]).first
				
				if(!qeury1.blank?)

						if(qeury1[:state]=='PENDING')
								
								
								return {"succes"=>0 , "message"=>"You have already sent him Friend Request. "}
								

						elsif (qeury1[:state]=='FRIEND')

								return {"success"=>0, 'message'=>'This user is already in your friend list.'}

						end
				else

						qeury2=Friend.where("user_id = ? AND friend_id = ?",params[:friend_id],user[:id]).first

						if(!qeury2.blank?)

								if(qeury2[:state]=='PENDING')
										
										
										return {"succes"=>0 , "message"=>"This user has already sent you friend request."}
										

								elsif (qeury2[:state]=='FRIEND')

										return {"success"=>0, 'message'=>'This user is already in your friend list.'}

								end
						
						else


								friend = Friend.create(user_id: user[:id], friend_id: params[:friend_id], state: 'PENDING')

								  if(friend.save)
								  	
								  			return {"success"=>1, 'message'=>'Request sent successfully.'}
								  else
								  	
								  	return {"success"=>0, 'message'=>'DB operation failed'}
								  end
						end
				end

		rescue Exception => e
		  
		  		return {'success'=>0, 'message'=>e.message}
		
		end
	end

	#----------------------------------------------------------------------------------------------------------
	#        Delete request of Friend and Delete its entry from "friends" Table 
	#----------------------------------------------------------------------------------------------------------
	def self.deleteRequest(params)
		begin
				params.require(:friend_id)
				params.require(:session_token)

				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end

				qeury=User.where(id: params[:friend_id]) 
				if(qeury.blank?)
						return {"success"=>0, 'message'=>'This friend_id does not belong to any user.'}
				end

			    qeury1=Friend.where("user_id = ? AND friend_id = ?",params[:friend_id],user[:id]).first
				if(qeury1.blank?)
						return {"success"=>0, 'message'=>'This user has not sent you friend request.'}
				else
					if(qeury1[:state]=='PENDING')
						
						qeury3=Friend.where("user_id = ? AND friend_id = ?",params[:friend_id],user[:id])
						.destroy_all
						
						if(qeury3.blank?)
							return {"succes"=>0 , "message"=>"DB operation failed"}
						else
							return {"success"=>1, "message"=>"Friend Request Successfully Deleted."}
						end
					
					elsif (qeury1[:state]=='FRIEND')

						return {"success"=>0, 'message'=>'This user is already in your friend list.'}

					end
				end
		rescue Exception => e
			return {"success"=>0, 'message'=>e.message}
		end

	end

#--------------------------------------------------------------------------------------------------------------------------------------



	def self.searchFriend(params)
		begin
				params.require(:page_no)
				params.require(:session_token)
				params.require(:keyword)

				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end

				page_no = params[:page_no].to_i
       			limit = 10
        		skip = (page_no-1)*limit
        		if (page_no< 1)
        			return {'success'=>0, 'message'=>'page_no should be greater than zero.'}
        		end	
        		qeury= User.select( "id, email ,full_name, 
        		CASE WHEN profile_type != 'IMAGE' 
        		THEN concat('#{ENV['VIDEO_PATH']}',profile_link) 
        		ELSE concat('#{ENV['IMAGE_PATH']}',profile_link) 
        		END as profile_link")
        		.where("id != ? AND full_name LIKE ?", user[:id],"%#{params[:keyword]}%" )
        		.order('full_name ASC')
        		.limit(10)
        		.offset(skip)

        		if (qeury.blank?)
        			return {"success"=>0 , "messagge"=>"No result Found"}
        		else
        			return {"success"=>1 , "message"=>qeury}
        		end
        	



		rescue Exception => e
			return {"success"=>0, 'message'=>e.message}
		end

	end

#-------------------------------------------------------------------------------------------------------------
end

#----------------------------------------------------------------------------------------------------------
#                                     End Of Friend Module
#-------------------------------------------------------------------------------------------------------------