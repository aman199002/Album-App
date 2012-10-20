class AlbumsController < ApplicationController
  before_filter :require_user

  def index    
    @albums = Album.all
  end  

  def new
    @album = Album.new
    1.times do 
      picture = @album.pictures.build
      picture.build_tag
    end  
  end

  def create        
    @album = current_user.albums.new(params[:album])
    if @album.save      
      post_to_facebook(@album.user) if @album.user.provider == "facebook"
      redirect_to @album
    else
      render :action => 'new'
    end  
  end

  def edit
    @album = Album.find(params[:id])  
  end

  def update
    @album = Album.find(params[:id])   
    
    if @album.update_attributes(params[:album])
      redirect_to @album
    else
      1.times {@album.pictures.build}
      render :action => 'new'
    end
  end

  def show    
    @album = Album.find(params[:id])
  end

  def destroy
    Album.find(params[:id]).destroy
    redirect_to albums_path
  end

  def my_albums
    @albums = current_user.albums
    render :index
  end  
end
