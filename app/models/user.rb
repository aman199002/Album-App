class User < ActiveRecord::Base
  has_many :albums
  attr_accessor :full_name, :new_user
  attr_accessible :name, :email, :password, :password_confirmation, :identifier_url, :first_name, :last_name, :provider, :uid, :oauth_token, :oauth_expires_at, :image
  acts_as_authentic do |c| 
    c.login_field = :email
  end

  after_create :post_to_facebook, :send_email  

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|      
      user.email = auth.provider == 'facebook' ? auth.info.email : "#{auth.info.nickname}@twitter.com"
      user.new_user = true if user.new_record?
      user.password = auth.uid
      user.password_confirmation = auth.uid
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.name.split(' ',2).first
      user.last_name = auth.info.name.split(' ',2).last
      user.image = user.set_image(auth)
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.provider == 'facebook'
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

  def full_name
    self.full_name = self.first_name + ' ' +self.last_name
  end

  def profile_photo(type)
    if self.provider == 'facebook'
      self.image = self.image.split('=').first+'='+type
    elsif self.provider == 'twitter'
      self.image
    end  
  end

  def set_image(auth)
    if auth.provider == 'twitter'
      self.image = auth.info.image.sub("_normal", "")
    else
      self.image
    end      
  end

  private
    def post_to_facebook
      if self.provider == 'facebook'
        graph = Koala::Facebook::API.new(self.oauth_token)        
        graph.put_connections("me", "feed", :message => "#{self.full_name} has been registered to #{DEFAULT_HOST}")
      end  
    end

    def send_email
      Notifier.register(self).deliver unless self.provider == "twitter"
    end    
end