class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])  	
  	if @user.save
      flash[:notice] = "Thank you for Signing Up!"
  	  redirect_to :controller => 'albums', :action => 'index'
  	else
  	  render :controller => "user_sessions",:action => "new"
  	end	
  end 	
  	
end
