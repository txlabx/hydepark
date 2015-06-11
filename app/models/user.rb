class User < ActiveRecord::Base
	

	has_many :posts


<<<<<<< HEAD


=======


>>>>>>> d0b6b13e89368c5e0cc92f28befc0e85c62d04f9
  #----------------------------------------------------------------------------------------------------------
  #                          Database Insertion Validations
  #-------------------------------------------------------------------------------------------------------------	validates :full_name, :profile_link, :profile_type,
  	
  	validates :full_name, :profile_link, :profile_type,:cover_link, :cover_type, :is_celeb, :session_token, :account_type, :last_login, :presence =>true
  	validates_length_of :password, :minimum => 6, :allow_blank => true 
  	#validates_date :date_of_birth, :before => lambda{Time.now.strftime("%Y-%m-%d")}, :allow_blank => true

  	validates_uniqueness_of :email, allow_blank: true
	validates :email, format: {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, allow_blank: true
	
	validates_inclusion_of :is_celeb, :in => [0,1]
	validates_inclusion_of :gender, :in => ['MALE', 'FEMALE', 'OTHER', ''], :message => "Invalid gender"
	validates_inclusion_of :account_type, :in => ['CUSTOM', 'FACEBOOK', 'TWITTER', 'GOOGLE_PLUS', 'INSTAGRAM'], :message => "Invalid account_type"
	


  #----------------------------------------------------------------------------------------------------------
  #                           Validate Session Token From 'users' table 
  #-------------------------------------------------------------------------------------------------------------

	def self.validate_session_token(session_token)
		user = User.where(session_token: session_token).first
		if(user.blank?)
			return false
		else
			return user
		end

	end


  #----------------------------------------------------------------------------------------------------------
  #                             Get Profile form 'users' Table 
  #-------------------------------------------------------------------------------------------------------------
	def self.getProfile(user)

<<<<<<< HEAD
		begin
=======
		#begin
>>>>>>> d0b6b13e89368c5e0cc92f28befc0e85c62d04f9
				
				if(user[:profile_type] == 'IMAGE')
					user[:'profile_link'] = "#{ENV['IMAGE_PATH']}/#{user[:profile_link]}"
					#hash.update(hash){ |k,v| "%#{image_path}%" }
				elsif(user[:profile_type] == 'VIDEO')
					user[:profile_link] = "#{ENV['VIDEO_PATH']}/#{user[:profile_link]}"
					#hash.update(hash){ |k,v| "%#{video_path}%" }
					#user.replace(h_image)
				end

				if(user[:cover_type] == 'IMAGE')
					user[:cover_link] = "#{ENV['IMAGE_PATH']}/#{user[:cover_link]}"
				elsif(user[:cover_type] == 'VIDEO')
					user[:cover_link] = "#{ENV['VIDEO_PATH']}/#{user[:cover_link]}"
				end
		 		user = user.as_json 
		 		
				user.delete('password')
				return user
<<<<<<< HEAD
		rescue Exception => e
			return {'status'=>'failure', 'message'=>e.message}
		end
=======
		#rescue Exception => e
		#	return {'status'=>'failure', 'message'=>e.message}
		#end
>>>>>>> d0b6b13e89368c5e0cc92f28befc0e85c62d04f9
	end
  
  #----------------------------------------------------------------------------------------------------------
  #                            Update Profile in 'users' Table 
  #-------------------------------------------------------------------------------------------------------------

	def self.updateProfile(params)
		begin
			session_token = params.fetch(:session_token)
			user = validate_session_token(session_token)
			if(!user)
				return {'status'=>'failure', 'message'=>'Invalid session_token'}
			end

<<<<<<< HEAD

			str = ''
			allowed_params = ['full_name', 'is_celeb', 'date_of_birth', 'gender', 'city', 'country']
			params.each do |key, value|
				if(allowed_params.include?(key))
					user[key] = value
				end
			end


=======

			str = ''
			allowed_params = ['full_name', 'is_celeb', 'date_of_birth', 'gender', 'city', 'country']
			params.each do |key, value|
				if(allowed_params.include?(key))
					user[key] = value
				end
			end


>>>>>>> d0b6b13e89368c5e0cc92f28befc0e85c62d04f9
			if(params.has_key?(:profile_link) && !params[:profile_link].blank?)
					profile_link = params[:profile_link]
				  	if(profile_link.class.name.demodulize == "UploadedFile")
				  		profile_link_name = SecureRandom.hex+File.extname(profile_link.original_filename)
				  		if(profile_link.content_type.split('/')[0] == 'image')
				  			profile_type = "IMAGE"
				  			if File.exist?(Rails.root.join('app', 'assets', 'images', user[:profile_link]))
				  				File.delete(Rails.root.join('app', 'assets', 'images', user[:profile_link]))
				  			end
					  		File.open(Rails.root.join('app', 'assets', 'images', profile_link_name), 'wb') do |file|
								file.write(profile_link.read)
							end
						elsif(profile_link.content_type.split('/')[0] == 'video')
							profile_type = "VIDEO"
							if File.exist?(Rails.root.join('app', 'assets', 'videos', user[:profile_link]))
				  				File.delete(Rails.root.join('app', 'assets', 'videos', user[:profile_link]))
				  			end
							File.open(Rails.root.join('app', 'assets', 'videos', profile_link_name), 'wb') do |file|
								file.write(profile_link.read)
							end
						else
							raise 'profile_link should be a video or image'
						end
						profile_link = profile_link_name
						user[:profile_link] = profile_link
						user[:profile_type] = profile_type
				  	else
				  		raise 'profile_link should be a file'
				  	end
			end

			if(params.has_key?(:cover_link) && !params.blank?(:cover_link))
					cover_link = params[:cover_link]
				  	if(cover_link.class.name.demodulize == "UploadedFile")
				  		cover_link_name = SecureRandom.hex+File.extname(cover_link.original_filename)
				  		if(cover_link.content_type.split('/')[0] == 'image')
				  			cover_type = 'IMAGE'
				  			if File.exist?(Rails.root.join('app', 'assets', 'images', user[:cover_link]))
				  				File.delete(Rails.root.join('app', 'assets', 'images', user[:cover_link]))
				  			end
					  		File.open(Rails.root.join('app', 'assets', 'images', cover_link_name), 'wb') do |file|
								file.write(cover_link.read)
							end
						elsif(cover_link.content_type.split('/')[0] == 'video')
							cover_type = 'VIDEO'
							if File.exist?(Rails.root.join('app', 'assets', 'videos', user[:cover_link]))
				  				File.delete(Rails.root.join('app', 'assets', 'videos', user[:cover_link]))
				  			end
							File.open(Rails.root.join('app', 'assets', 'videos', cover_link_name), 'wb') do |file|
								file.write(cover_link.read)
							end
						else
							raise 'cover_link should be a video or image'
						end
						cover_link = cover_link_name
						user[:cover_link] = cover_link
						user[:cover_type] = cover_type
				  	else
				  		raise 'profile_link should be a file'
				  	end
			end
			
			if(user.save)
			  	return {'status'=>'ok', 'message'=>'User successfully updated'}
			else
			  	message = ""
			  	user.errors.messages.each do |msg_field|
			  		msg_field.each do |msg|
			  			message = "#{message} #{msg} " 
			  		end
			  	end
			  	return {'status'=>'failure', 'message'=>message}
			end


		rescue Exception => e
			return {'status'=>'failure', 'message'=>e.message}
		end

	end
  
  #----------------------------------------------------------------------------------------------------------
  #                            User Sign In from 'users' Table 
  #-------------------------------------------------------------------------------------------------------------

	def self.userSignIn(params)
		begin
			email = params.fetch(:email)
			password = Digest::SHA1.hexdigest(params.fetch(:password))

			user_exists = User.where(email: email, password: password).first
		  	if(user_exists.blank?)
		  		return {'status'=>'failure', 'message'=>'Invalid Email or password.'}
		  	else
		  		user_exists.last_login = Time.now.to_i
		  		user_exists.save
		  		return {'status'=>'ok', 'profile'=>getProfile(user_exists)}
		  	end

		rescue Exception => e
			return {'status'=>'failure', 'message'=>e.message}
		end
	end

  #----------------------------------------------------------------------------------------------------------
  #                             User Registration in 'users' Table 
  #-------------------------------------------------------------------------------------------------------------
	
	def self.registerUser(params)
		begin
			is_celeb=0
		  full_name = params.fetch(:full_name)
		  account_type = params.fetch(:account_type)
		  email = params.fetch(:email)

		  if(account_type == 'CUSTOM')
		  	password = Digest::SHA1.hexdigest(params.fetch(:password))
		  	is_celeb=params.fetch(:is_celeb)
		  else
		  	user_exists = User.where(email: email).first
		  	if(user_exists.blank?)
		  		password = ''
		  	else
		  		return {'status'=>'ok', 'profile'=>getProfile(user_exists)}
		  	end
		  end

		  #optional
		  gender = params.has_key?(:gender) ? params[:gender] : ""

		  #optional
		  date_of_birth = (params.has_key?(:date_of_birth) && !params[:date_of_birth].empty?) ? Time.at(params[:date_of_birth].to_i).to_date : ""
		  
		  #optional
		  profile_link = params.has_key?(:profile_link) ? params[:profile_link] : ENV['DEFAULT_PROFILE_IMAGE_NAME']
		  profile_type = "IMAGE"
		  if(params.has_key?(:profile_link))
		  	profile_link_name = SecureRandom.hex+File.extname(profile_link.original_filename)
		  	if(profile_link.class.name.demodulize == "UploadedFile")
		  		if(profile_link.content_type.split('/')[0] == 'image')
		  			profile_type = "IMAGE"
			  		File.open(Rails.root.join('app', 'assets', 'images', profile_link_name), 'wb') do |file|
						file.write(profile_link.read)
					end
				elsif(profile_link.content_type.split('/')[0] == 'video')
					profile_type = "VIDEO"
					File.open(Rails.root.join('app', 'assets', 'videos', profile_link_name), 'wb') do |file|
						file.write(profile_link.read)
					end
				end
				profile_link = profile_link_name
		  	else
		  		raise 'profile_link should be a file'
		  	end
		  end

		  #optional
		  cover_link = params.has_key?(:cover_link) ? params[:cover_link] : ENV['DEFAULT_COVER_IMAGE_NAME']
		  cover_type = 'IMAGE'
		  if(params.has_key?(:cover_link))
		  	cover_link_name = SecureRandom.hex+File.extname(cover_link.original_filename)
		  	if(cover_link.class.name.demodulize == "UploadedFile")
		  		if(cover_link.content_type.split('/')[0] == 'image')
		  			cover_type = 'IMAGE'
			  		File.open(Rails.root.join('app', 'assets', 'images', cover_link_name), 'wb') do |file|
						file.write(cover_link.read)
					end
				elsif(cover_link.content_type.split('/')[0] == 'video')
					cover_type = 'VIDEO'
					File.open(Rails.root.join('app', 'assets', 'videos', cover_link_name), 'wb') do |file|
						file.write(cover_link.read)
					end
				end
				cover_link = cover_link_name
		  	else
		  		raise 'profile_link should be a file'
		  	end
		  end

		  session_token = SecureRandom.hex
		  last_login = Time.now.to_i

		  user = User.create(full_name: full_name, account_type: account_type, email: email,
		   password: password, gender: gender, date_of_birth: date_of_birth, profile_link: profile_link,
		   profile_type: profile_type, cover_link: cover_link, cover_type: cover_type, session_token: session_token,
		    last_login: last_login, is_celeb: is_celeb)

		  if(user.save)
		  	return {'status'=>'ok', 'message'=>'User successfully created'}
		  else
		  	message = ""
		  	user.errors.messages.each do |msg_field|
		  		msg_field.each do |msg|
		  			message = "#{message} #{msg} " 
		  		end
		  	end
		  	return {'status'=>'failure', 'message'=>message}
		  end

		rescue Exception => e
		  return {'status'=>'failure', 'message'=>e.message}
		end
	end

#--------------------------------------------------------------------------------------------------------

end


#----------------------------------------------------------------------------------------------------------
#                                     End Of User Module
#-------------------------------------------------------------------------------------------------------------