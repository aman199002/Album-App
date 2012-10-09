ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.default :charset => "utf-8" 
ActionMailer::Base.smtp_settings = {
    enable_starttls_auto: true,
    openssl_verify_mode: 'none',
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "album-app-aman.herokuapp.com/",
    :authentication => :plain,
    :user_name => "noreply.albumapp@gmail.com",
    :password => "changeIT123"
  }