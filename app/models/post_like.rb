class PostLike < ActiveRecord::Base
belongs_to :post


	#----------------------------------------------------------------------------------------------------------
	#                                Post Like 
	#----------------------------------------------------------------------------------------------------------
	def self.postLike(params)
			
			begin
					params.require(:session_token)
					params.require(:post_id)

					session_token = params.fetch(:session_token)
					user= User.validate_session_token(session_token)
					
					if(user.blank?)
							return {'success'=>0, 'message'=>'Invalid session_token.'}
					end
					query=Post.find_by_sql("SELECT * FROM posts WHERE id = '#{params[:post_id]}'")
					
					if (query.blank?)
						return {'success'=>0, 'message'=>'post does not exist'}
					end

					query2=PostLike.find_by_sql("SELECT * FROM post_likes WHERE post_id = '#{params[:post_id]}' AND user_id = '#{user[:id]}'")
					
					if(!query2.blank?)
						return {'success'=>0, 'message'=>'User have already liked the post'}
					end
			
					query3=PostLike.create(user_id: user[:id], post_id: params[:post_id])
					
					if(query3.save)
						return {'success'=>1, 'message'=>'Post is Successfully Liked.'}
					else
						return {'success'=>0, 'message'=>'DB operation failed.'}
					end


			rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end
end
