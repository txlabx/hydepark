# Load the Rails application.
require File.expand_path('../application', __FILE__)


# Initialize the Rails application.

ENV['DEFAULT_PROFILE_IMAGE_NAME'] = 'no_image_profile.png'
ENV['DEFAULT_COVER_IMAGE_NAME'] = 'no_image_cover.JPG'
ENV['IMAGE_PATH'] = Rails.root.join('app', 'assets', 'images').to_s
ENV['VIDEO_PATH'] = Rails.root.join('app', 'assets', 'videos').to_s
ENV['LOCAL_PATH'] = "http://localhost:3000/assets/"

ENV['SESSION_EXPIRES_SECONDS'] = '10000000000000000000'

Rails.application.initialize!