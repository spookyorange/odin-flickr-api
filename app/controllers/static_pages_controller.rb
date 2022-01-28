class StaticPagesController < ApplicationController
  def index
    @id_parameter = params[:id] if params[:id] != nil
    
    if @id_parameter != nil
      @flickr = Flickr.new ENV['FLICKR_API_KEY'], ENV['FLICKR_SHARED_SECRET']
      @return = @flickr.people.getPhotos :user_id => params[:id], :accept => :json
      @infos = @return.to_a.slice(0..4).map do |response| 
        @flickr.photos.getInfo(:photo_id => response.id)
      end

      @photo_urls = @infos.map do |info|
        Flickr.url_b(info)
      end
    end
  end
end
