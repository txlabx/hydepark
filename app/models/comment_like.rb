class CommentLike < ActiveRecord::Base
belongs_to :comment

	#----------------------------------------------------------------------------------------------------------
	#                                Comment Like
	#----------------------------------------------------------------------------------------------------------
	def self.likeComment(params)
			
			begin
					params.require(:session_token)
					params.require(:comment_id)

					session_token = params.fetch(:session_token)
					user= User.validate_session_token(session_token)
					
					if(user.blank?)
							return {'success'=>0, 'message'=>'Invalid session_token.'}
					end
					query=Comment.find_by_sql("Select * from comments where id= '#{params[:comment_id]}'")
					
					if (query.blank?)
						return {'success'=>0, 'message'=>'comment does not exist'}
					end

					query2=CommentLike.find_by_sql("Select * from comment_likes where user_id= '#{user[:id]}' and comment_id='#{params[:comment_id]}'")
					
					if(!query2.blank?)
						return {'success'=>0, 'message'=>'User have already liked the comment'}
					end
			
					query3=CommentLike.create(user_id: user[:id], comment_id: params[:comment_id])
					
					if(query3.save)
						return {'success'=>1, 'message'=>'Comment is Successfully Liked.'}
					else
						return {'success'=>0, 'message'=>'DB operation failed.'}
					end


			rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end



end
