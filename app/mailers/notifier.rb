class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def register(user)
  	@user = user    
    mail(to: user.email, subject: "Welcome to Album App")
  end	

end
