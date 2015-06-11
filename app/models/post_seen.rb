class PostSeen < ActiveRecord::Base
belongs_to :post

	#----------------------------------------------------------------------------------------------------------
	#                                Post Views
	#----------------------------------------------------------------------------------------------------------
	def self.postViews(params)
			
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

					query2=PostLike.find_by_sql("SELECT * FROM post_seens WHERE post_id = '#{params[:post_id]}' AND user_id = '#{user[:id]}'")
					
					if(!query2.blank?)
						return {'success'=>0, 'message'=>'User have already seen the post'}
					end
			
					query3=PostSeen.create(user_id: user[:id], post_id: params[:post_id])
					
					if(query3.save)
						return {'success'=>1, 'message'=>'Post is Successfully Seen.'}
					else
						return {'success'=>0, 'message'=>'DB operation failed.'}
					end


			rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end
end
