class AlbumsController < ApplicationController
  before_filter :require_user

  def index
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
      redirect_to :action => 'show', :id => @album.id
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
      redirect_to :action => 'show', :id => @album.id
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
    redirect_to :action => 'index'
  end

end
