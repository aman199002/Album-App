class Notifier < ActionMailer::Base
  default from: "'Albums' noreply.albumapp@gmail.com"

  def register(user)
  	@user = user    
    mail(to: user.email, subject: "Welcome to Album App")
  end	

end