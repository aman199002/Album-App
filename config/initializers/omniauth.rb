OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_API_KEY, FACEBOOK_SECRET_KEY,:scope =>"publish_stream"
end