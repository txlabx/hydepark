class Post < ActiveRecord::Base


	has_many :post_likes
	has_many :post_seens
	has_many :comments
	has_many :tags
	belongs_to :topic
	belongs_to :user

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
	#                                 Validate Topic Id From "topics" Table 
	#----------------------------------------------------------------------------------------------------------
	def self.validate_topic_id(topic_id)
			
			begin
				topic = Topic.where(id: topic_id).first
				
				if(topic.blank?)
					return false
				else
					return topic
				end

			rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end


	


	#----------------------------------------------------------------------------------------------------------
	#                                    Get Post By Id 
	#----------------------------------------------------------------------------------------------------------
	def self.postById(params)
		
		begin
				params.require(:id)
				params.require(:session_token)

				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end

				like_count = 0;
			    comment_count = 0;
				qeury=Post.select(" posts.id, posts.user_id, users.full_name,
					concat('#{ENV['LOCAl_PATH']}', users.profile_link) 
					as profile_link,
					users.profile_type, posts.caption,
					CASE WHEN posts.video_link != '' 
					THEN concat('#{ENV['LOCAl_PATH']}', posts.video_link)
					ELSE posts.video_link 
					END as video_link,
					CASE WHEN posts.video_thumbnail_link != '' 
					THEN concat('#{ ENV['LOCAL_PATH']}', posts.video_thumbnail_link) 
					ELSE posts.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN posts.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', posts.image_link) 
					ELSE posts.image_link 
					END as image_link,
					posts.video_angle, posts.privacy, posts.topic_id,
					count(post_likes.id) as like_count, count(comments.id) as comment_count")
				.where('posts.id=?', params[:id])
				.joins('LEFT OUTER JOIN post_likes ON post_likes.post_id = posts.id')
				.joins('LEFT OUTER JOIN comments ON comments.post_id = posts.id')
				.joins(" INNER JOIN users ON posts.user_id = users.id")
				.group('posts.id')
				

				if qeury.blank?
					return {"success"=>0, "message"=>"There is no Post associated with this Post ID"}
				else
					return {"success"=>1, "message"=>qeury}
				end

		rescue Exception => e
		
			return {"success"=>0, 'message'=>e.message}
		end
	end

	#----------------------------------------------------------------------------------------------------------
	#                                Get Content By Topic ID 
	#----------------------------------------------------------------------------------------------------------
	def self.contentByTopic(params)
		begin

				params.require(:topicId)
				params.require(:session_token)
				params.require(:page_no)


				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end
				page_no = params[:page_no].to_i
		        limit = 10
		        skip = (page_no-1)*limit
				
				qeury=Post.select(" posts.id, posts.user_id, users.full_name,
					concat('#{ENV['LOCAl_PATH']}', users.profile_link) 
					as profile_link,
					users.profile_type, posts.caption,
					CASE WHEN posts.video_link != '' 
					THEN concat('#{ENV['LOCAl_PATH']}', posts.video_link)
					ELSE posts.video_link 
					END as video_link,
					CASE WHEN posts.video_thumbnail_link != '' 
					THEN concat('#{ ENV['LOCAL_PATH']}', posts.video_thumbnail_link) 
					ELSE posts.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN posts.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', posts.image_link) 
					ELSE posts.image_link 
					END as image_link,
					posts.video_angle, posts.privacy, posts.topic_id,
					count(post_likes.id) as like_count, count(comments.id) as comment_count")
				.joins('LEFT OUTER JOIN post_likes ON post_likes.post_id = posts.id')
				.joins('LEFT OUTER JOIN comments ON comments.post_id = posts.id')
				.joins(" INNER JOIN users ON posts.user_id = users.id")
				.where('posts.topic_id=? AND posts.privacy=?', params[:topicId],'Public')
				.limit(10)
				.offset(skip)
				.group('posts.id')

				if qeury.blank?
					return {"success"=>0, "message"=>"There are no posts to display"}
				else
					return {"success"=>1, "message"=>qeury}
				end

		rescue Exception => e
		
			return {"success"=>0, 'message'=>e.message}
		end
			
	end


	#----------------------------------------------------------------------------------------------------------
	#                                Get Home Content
	#----------------------------------------------------------------------------------------------------------
	def self.homeContent(post)
		
		begin
				session_token = post.fetch(:session_token)
				user= validate_session_token(session_token)
				if(!user)
						return {'status'=>'failure', 'message'=>'Invalid session_token'}
				end

				page_no = post[:page_no].to_i
		        limit = 10
		        skip = (page_no-1)*limit

		       
		        
		      	 qeury1=Post.select(" posts.id, posts.user_id, users.full_name,
					concat('#{ENV['LOCAl_PATH']}', users.profile_link) 
					as profile_link,
					users.profile_type, posts.caption,
					CASE WHEN posts.video_link != '' 
					THEN concat('#{ENV['LOCAl_PATH']}', posts.video_link)
					ELSE posts.video_link 
					END as video_link,
					CASE WHEN posts.video_thumbnail_link != '' 
					THEN concat('#{ ENV['LOCAL_PATH']}', posts.video_thumbnail_link) 
					ELSE posts.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN posts.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', posts.image_link) 
					ELSE posts.image_link 
					END as image_link,
					posts.video_angle, posts.privacy, posts.topic_id,
					count(post_likes.id) as like_count, count(comments.id) as comment_count")
		      	.joins('LEFT OUTER JOIN post_likes ON posts.id = post_likes.post_id')
		        .joins('LEFT OUTER JOIN comments ON posts.id = comments.post_id')
				.joins('LEFT OUTER JOIN users ON posts.user_id = users.id')
				.where('posts.user_id=?', user[:id])
				.group('posts.id')
		        .limit(10)
				.offset(skip)
				
				qeury2=Post.find_by_sql("SELECT p.id, p.user_id, 
					concat('#{ENV['LOCAL_PATH']}', u.profile_link) as profile_link,u.full_name, 
					CASE WHEN p.video_link != ''
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_link) 
					ELSE p.video_link 
					END as video_link,
					CASE WHEN p.video_thumbnail_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_thumbnail_link) 
					ELSE p.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN p.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.image_link) 
					ELSE p.image_link 
					END as image_link,
					p.video_angle, p.privacy, p.topic_id, p.created_at, 
					count(pl.id) as like_count, count(c.id) as comment_count
					FROM posts p 
		            LEFT OUTER JOIN post_likes pl 
		            ON p.id = pl.post_id 
		            LEFT OUTER JOIN comments c 
		            ON p.id = c.post_id
		            LEFT OUTER JOIN users u 
		            ON p.user_id = u.id
		            WHERE p.user_id IN(SELECT friend_id FROM friends 
		                                WHERE user_id = '#{user[:id]}' 
		                                AND state = 'FRIEND' 
		                                UNION
		                                SELECT user_id FROM friends 
		                                WHERE friend_id = '#{user[:id]}' 
		                                AND state = 'FRIEND') 
		            AND p.privacy != 'PRIVATE'
		            GROUP BY p.id ORDER BY p.created_at DESC")

		        

		        friends=Friend.find_by_sql("SELECT f.friend_id, u.full_name,
									         u.email, u.profile_link, u.cover_link, u.is_celeb 
									         FROM friends f 
									         LEFT OUTER JOIN users u 
									         On f.friend_id=u.id 
									         where f.user_id=1 
									         OR f.friend_id=1 
									         and f.state='FRIEND'")


	       	   	qeury=qeury1|qeury2

				if qeury.blank?
					return {"success"=>0 , "message"=>"There are no posts to show"}
				else
					return {"success"=>1, "posts"=>qeury, "friends"=>friends}
				end
			
			rescue Exception => e
		
					return {"success"=>0, 'message'=>e.message}
			end

	end

	#----------------------------------------------------------------------------------------------------------
	#                                Get User Post 
	#----------------------------------------------------------------------------------------------------------

	def self.userPost(params)
		
		begin
				params.require(:session_token)
				params.require(:page_no)


				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end
				page_no = params[:page_no].to_i
		        limit = 10
		        skip = (page_no-1)*limit

		        qeury=Post.select(" posts.id, posts.user_id, users.full_name,
					concat('#{ENV['LOCAl_PATH']}', users.profile_link) 
					as profile_link,
					users.profile_type, posts.caption,
					CASE WHEN posts.video_link != '' 
					THEN concat('#{ENV['LOCAl_PATH']}', posts.video_link)
					ELSE posts.video_link 
					END as video_link,
					CASE WHEN posts.video_thumbnail_link != '' 
					THEN concat('#{ ENV['LOCAL_PATH']}', posts.video_thumbnail_link) 
					ELSE posts.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN posts.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', posts.image_link) 
					ELSE posts.image_link 
					END as image_link,
					posts.video_angle, posts.privacy, posts.topic_id,
					count(post_likes.id) as like_count, count(comments.id) as comment_count")
		        .joins('LEFT OUTER JOIN post_likes ON posts.id = post_likes.post_id')
		        .joins('LEFT OUTER JOIN comments ON posts.id = comments.post_id')
				.joins('LEFT OUTER JOIN users ON posts.user_id = users.id')
				.where('posts.user_id=?', user[:id])
				.group('posts.id')
		        .limit(10)
				.offset(skip)
				
				if qeury.blank?
					return {"success"=>0, "message"=>"There are no Posts to display"}
				else
					return {"success"=>1, "message"=>qeury}
				end

         
			rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end

	#----------------------------------------------------------------------------------------------------------
	#                               Upload Status 
	#----------------------------------------------------------------------------------------------------------


def self.uploadStatus(params)
		begin
			params.require(:mute)
			mute = params.fetch(:mute)

			session_token = params.fetch(:session_token)
			user = validate_session_token(session_token)
			if(!user)
				return {'success'=>0, 'message'=>'Invalid session_token'}
			end

			topic_id = params.fetch(:topic_id)
			topic = validate_topic_id(topic_id)
			if(!topic)
				return {'success'=>0, 'message'=>'Invalid topic_id'}
			end

			privacy = params.fetch(:privacy)
			reply_count = params.fetch(:reply_count)
			filter = params.fetch(:filter)
			beam_type = "NORMAL"
			video_link = ""
			video_thumbnail_link = ""
			image_link = ""

			caption =""
			video_angle = ""
			video_length=0

			#video and thumbnail
			if(params.has_key?(:video_link) && !params[:video_link].blank?)
				if(params.has_key?(:video_thumbnail_link) && !params[:video_thumbnail_link].blank?)
					video_angle = params.fetch(:video_angle)
					video_length=params.fetch(:video_length)
					video_link = params[:video_link]
					video_thumbnail_link = params[:video_thumbnail_link]
					if(video_link.class.name.demodulize == "UploadedFile" && video_thumbnail_link.class.name.demodulize == "UploadedFile")
						video_link_name = SecureRandom.hex+File.extname(video_link.original_filename)
						video_thumbnail_link_name = SecureRandom.hex+File.extname(video_thumbnail_link.original_filename)
						if(video_link.content_type.split('/')[0] == 'video' && video_thumbnail_link.content_type.split('/')[0] == 'image')
							File.open(Rails.root.join('app', 'assets', 'videos', video_link_name), 'wb') do |file|
								file.write(video_link.read)
							end
							File.open(Rails.root.join('app', 'assets', 'images', video_thumbnail_link_name), 'wb') do |file|
								file.write(video_thumbnail_link.read)
							end
						else
							raise 'video_link should be a video & video_thumbnail_link should be an image'
						end
						video_link = video_link_name
						video_thumbnail_link = video_thumbnail_link_name
					else
						raise 'Both video_link & video_thumbnail_link should be files'
					end
				else
					raise 'Missing parameter video_thumbnail_link'
				end
			#video rotation
                    #params['video_angle' += 90;
                    #cmd = "ffmpeg -i temp/'#{temp_name}' -vf scale=iw:ih,rotate='#{params[:video_angle]}'*PI/180:bilinear=0 videos/1'#{filename}'";
                    #exec(cmd);

                    #cmd = "ffmpeg -i videos/1'#{filename}' -i watermark/watermark.png -filter_complex 'overlay=x=(main_w-overlay_w-10):y=(main_h-overlay_h-10)' -codec:a copy videos/'#{filename}'";
                    #exec(cmd);

                    #unlink("videos/1'#{filename}'");
                    #unlink("temp/'#{temp_name}'");

			#elsif(params.has_key?(:audio_link) && !params[:audio_link].blank?)#audio and image
			#	if(params.has_key?(:image_link) && !params[:image_link].blank?)
			#		image_link = params[:image_link]
			#		audio_link = params[:audio_link]
			#		if(audio_link.class.name.demodulize == "UploadedFile" && image_link.class.name.demodulize == "UploadedFile")
			#			audio_link_name = SecureRandom.hex+File.extname(audio_link.original_filename)
			#			image_link_name = SecureRandom.hex+File.extname(image_link.original_filename)
			#			if(audio_link.content_type.split('/')[0] == 'audio' && image_link.content_type.split('/')[0] == 'image')
			#				#File.open(Rails.root.join('app', 'assets', 'videos', video_link_name), 'wb') do |file|
			#				#	file.write(video_link.read)
			#				#end
			#				#File.open(Rails.root.join('app', 'assets', 'images', video_thumbnail_link_name), 'wb') do |file|
			#				#	file.write(video_thumbnail_link.read)
			#				#end
			#			#else
			#			#	raise 'video_link should be a video & video_thumbnail_link should be an image'
			#			end
			#			#video_link = video_link_name
			#			#video_thumbnail_link = video_thumbnail_link_name
			#		else
			#			raise 'Both audio_link & image_link should be files'
			#		end
			#	else
			#		raise 'Missing parameter image_link'
			#	end
			
			elsif(params.has_key?(:image_link) && !params[:image_link].blank?)#image
				image_link = params[:image_link]
				if(image_link.class.name.demodulize == "UploadedFile")
					image_link_name = SecureRandom.hex+File.extname(image_link.original_filename)
					if(image_link.content_type.split('/')[0] == 'image')
						File.open(Rails.root.join('app', 'assets', 'images', image_link_name), 'wb') do |file|
							file.write(image_link.read)
						end
					else
						raise 'image_link should be an image'
					end
					image_link = image_link_name
				else
					raise 'image_link should be a file'
				end
			elsif(params.has_key?(:caption))
					caption=params.fetch(:caption)
			else

				raise 'Invalid input'
			end

			post = Post.create(user: user, caption: caption, video_link: video_link, video_thumbnail_link: video_thumbnail_link,
				image_link: image_link, video_angle: video_angle, privacy: privacy, topic: topic, reply_count: reply_count,
				beam_type: beam_type, filter: filter, mute: mute, video_length: video_length)

			if(post.save)
				return {'success'=>1, 'message'=>'Post successfully uploaded', 'post'=>post}
			else
				message = ""
			  	post.errors.messages.each do |msg_field|
			  		msg_field.each do |msg|
			  			message = "#{message} #{msg} " 
			  		end
			  	end
			  	return {'success'=>0, 'message'=>message}
			end

		rescue Exception => e
			return {'success'=>0, 'message'=>e.message}
		end
	end


	#----------------------------------------------------------------------------------------------------------
	#                                Get User Beams
	#----------------------------------------------------------------------------------------------------------

	def self.userBeam(params)
		
		begin
				params.require(:session_token)
				params.require(:page_no)


				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end
				page_no = params[:page_no].to_i
		        limit = 10
		        skip = (page_no-1)*limit

		  
		        friends_count= Friend.find_by_sql("SELECT COUNT(*) as friends_count FROM friends WHERE user_id = '#{user[:id]}' OR friend_id = '#{user[:id]}' AND state='FRIEND'").first
        		
       			beam_count= Post.find_by_sql("SELECT COUNT(*) as beams_count from posts WHERE user_id = '#{user[:id]}' AND video_link != ''").first
        		like_count = 0

		        qeury=Post.find_by_sql("SELECT p.id, p.user_id, 
					concat('#{ENV['LOCAL_PATH']}', u.profile_link) as profile_link,u.full_name, 
					CASE WHEN p.video_link != ''
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_link) 
					ELSE p.video_link 
					END as video_link,
					CASE WHEN p.video_thumbnail_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_thumbnail_link) 
					ELSE p.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN p.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.image_link) 
					ELSE p.image_link 
					END as image_link,
					p.video_angle, p.privacy, p.topic_id, p.created_at, 
					count(pl.id) as like_count, count(c.id) as comment_count
		            FROM posts p 
		            LEFT OUTER JOIN post_likes pl 
		            ON p.id = pl.post_id 
		            LEFT OUTER JOIN comments c 
		            ON p.id = c.post_id
		            LEFT OUTER JOIN users u 
		            ON p.user_id = u.id
		            WHERE p.user_id = '#{user[:id]}' 
		            AND p.video_link != ''
		            GROUP BY p.id
		            ORDER BY p.created_at DESC")
				
			
				if qeury.blank?
					return {"success"=>0, "message"=>"There are no Beams to display"}
				else
					return {"success"=>1, "beams"=>qeury , "beam_count"=>beam_count[:beams_count] , "friend_count"=>friends_count[:friends_count] }
				end

         
			rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end



	#----------------------------------------------------------------------------------------------------------
	#                                Get My Channel
	#----------------------------------------------------------------------------------------------------------

	def self.myChannel(params)
		
		begin
				params.require(:session_token)
				params.require(:page_no)


				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end
				page_no = params[:page_no].to_i
		        limit = 10
		        skip = (page_no-1)*limit

		  
		        friends_count= Friend.find_by_sql("SELECT COUNT(*) as friends_count FROM friends WHERE user_id = '#{user[:id]}' OR friend_id = '#{user[:id]}' AND state='FRIEND'").first
        		
       			beam_count= Post.find_by_sql("SELECT COUNT(*) as beams_count from posts WHERE user_id = '#{user[:id]}' AND video_link != ''").first
        		like_count = 0

        		profile = User.getProfile(user)
        		

		        qeury=Post.find_by_sql("SELECT p.id, p.user_id, 
					concat('#{ENV['LOCAL_PATH']}', u.profile_link) as profile_link,u.full_name,u.is_celeb, 
					CASE WHEN p.video_link != ''
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_link) 
					ELSE p.video_link 
					END as video_link,
					CASE WHEN p.video_thumbnail_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_thumbnail_link) 
					ELSE p.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN p.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.image_link) 
					ELSE p.image_link 
					END as image_link,
					p.video_angle, p.privacy, p.topic_id, p.created_at, 
					count(pl.id) as like_count, count(c.id) as comment_count
		            FROM posts p 
		            LEFT OUTER JOIN post_likes pl 
		            ON p.id = pl.post_id 
		            LEFT OUTER JOIN comments c 
		            ON p.id = c.post_id
		            LEFT OUTER JOIN users u 
		            ON p.user_id = u.id
		            WHERE p.user_id = '#{user[:id]}' 
		            AND p.video_link != ''
		            GROUP BY p.id
		            ORDER BY p.created_at DESC")
				
			
				if qeury.blank?
					return {"success"=>0, "message"=>"There are no Beams to display"}
				else
					return {"success"=>1, "beams"=>qeury , "beam_count"=>beam_count[:beams_count] , "friend_count"=>friends_count[:friends_count], "profile"=>profile }
				end

         
			rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end

	#----------------------------------------------------------------------------------------------------------
	#                                Get Trending Videos
	#----------------------------------------------------------------------------------------------------------

	def self.trendingVideos(params)
		
		begin
				params.require(:session_token)
				params.require(:page_no)


				session_token = params.fetch(:session_token)
				user= validate_session_token(session_token)
				
				if(user.blank?)
						return {'success'=>0, 'message'=>'Invalid session_token.'}
				end
				page_no = params[:page_no].to_i
		        limit = 10
		        skip = (page_no-1)*limit

		        query=PostSeen.find_by_sql("SELECT ps.post_id, p.user_id, 
					concat('#{ENV['LOCAL_PATH']}', u.profile_link) as profile_link,u.full_name,u.is_celeb, 
					CASE WHEN p.video_link != ''
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_link) 
					ELSE p.video_link 
					END as video_link,
					CASE WHEN p.video_thumbnail_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.video_thumbnail_link) 
					ELSE p.video_thumbnail_link 
					END as video_thumbnail_link,
					CASE WHEN p.image_link != '' 
					THEN concat('#{ENV['LOCAL_PATH']}', p.image_link) 
					ELSE p.image_link 
					END as image_link,
					p.video_angle, p.privacy, p.topic_id, p.created_at, 
					count(pl.id) as like_count, count(c.id) as comment_count,count(ps.post_id) as post_seen_count
					FROM post_seens ps inner join posts p on p.id = ps.post_id
					LEFT OUTER JOIN post_likes pl 
		            ON p.id = pl.post_id 
		            LEFT OUTER JOIN comments c 
		            ON p.id = c.post_id
		            LEFT OUTER JOIN users u 
		            ON p.user_id = u.id
		            WHERE p.privacy = 'PUBLIC' 
		            AND p.video_link != ''
		            GROUP BY p.id")
				if(query.any?)
					return {"success"=>1, 'message'=>query}
				else
					return {"success"=>1, 'message'=>"There are no trending videos"}
				end

		rescue Exception => e
		
				return {"success"=>0, 'message'=>e.message}
			end
	end


#-------------------------------------------------------------------------------------------------------------
end
#----------------------------------------------------------------------------------------------------------
#                                     End Of Post Module
#-------------------------------------------------------------------------------------------------------------