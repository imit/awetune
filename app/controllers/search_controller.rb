class SearchController < ApplicationController
  
  def search
    search = Search.where(:query => params[:query]).first
    if search.blank?
      search = Search.create!(:query => params[:query], :last_crawled_at => Time.now)
      Video.search_all(search.query)
    else
      if search.last_crawled_at < Time.now - 15.minutes
        Video.search_all(search.query)
        search.update_attributes(:last_crawled_at => Time.now)
      end
    end
    
    @results = Video.tagged_with([search.query], :any => true)
    render :results
  end
  
  
  def manual
    q= params[:query]
    youtube = YouTubeIt::Client.new(:dev_key => Video::YOUTUBE_DEV_KEY)
    @youtubes = youtube.videos_by({ :query => q })
   
    vimeo = Vimeo::Advanced::Video.new(Video::VIMEO_AUTH, Video::VIMEO_SECRET)
    @vimeos = vimeo.search(q)
    render :all
  end
  
end
