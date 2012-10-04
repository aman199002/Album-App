class User < ActiveRecord::Base
  has_many :albums
  attr_accessible :name, :email, :password, :password_confirmation, :identifier_url, :first_name, :last_name, :provider, :uid, :oauth_token, :oauth_expires_at
  acts_as_authentic do |c| 
  	c.login_field = :email
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.email = auth.info.email  
      user.password = auth.uid
      user.password_confirmation = auth.uid
      #user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.name.split(' ',2).first
      user.last_name = auth.info.name.split(' ',2).last
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)      
      user.save!
    end
  end

  def self.from_google(openid)
    ax = OpenID::AX::FetchResponse.from_success_response(openid)
    user = User.where(:identifier_url => openid.display_identifier).first
    user ||= User.create!(:identifier_url => openid.display_identifier,
                          :email => ax.get_single('http://axschema.org/contact/email'),
                          :first_name => ax.get_single('http://axschema.org/namePerson/first'),
                          :last_name => ax.get_single('http://axschema.org/namePerson/last'),
                          :password => openid.display_identifier.split('=').last,
                          :password_confirmation => openid.display_identifier.split('=').last,
                          :provider => 'google'
                          )    
  end  

end