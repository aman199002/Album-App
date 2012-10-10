class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user
  private
    def current_user_session
      logger.debug "ApplicationController::current_user_session"
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      logger.debug "ApplicationController::current_user"
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
 
    def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user        
        flash[:notice] = "You must be logged in to access this page"
        redirect_to :controller => 'user_sessions',:action => 'new'
        return false
      end
    end
 
    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user        
        flash[:notice] = "You must be logged out to access this page"
        redirect_to :controller => 'albums', :action => 'index'
        return false
      end
    end
 
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    private
      def post_to_facebook(user,album)        
        @graph = Koala::Facebook::API.new(user.oauth_token)
        if album
          @graph.put_connections("me", "feed", :message => "#{user.full_name} has just uploaded album #{@album.name} on #{root_url}")
        else
          @graph.put_connections("me", "feed", :message => "#{user.full_name} has been registered to #{root_url}")
        end  
      end  

end
