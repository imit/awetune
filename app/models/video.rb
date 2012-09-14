class Video < ActiveRecord::Base
  
  # 
  # t.integer :media_id
  # t.string :title
  # t.string :thumbnail
  # t.integer :media_type
  # 
  # 
	#    vimeo.id
	#    vimeo.title
	#    vimeo.license
	#    vimeo.privacy
	#    vimeo.is_hd
	#    vimeo.embed_privacy
	#    vimeo.owner_id
	#    vimeo.modified_date
	#    	
	#    youtube.title
	#    youtube.unique_id
	#    youtube.thumbnails[]
	#    youtube.keywords[]
	#    youtube.categories[]
	#    youtube.duration
	#    youtube.description
	#    youtube.embeddable?
  #    
  
  
  
  attr_accessible :media_id, :media_type, :title
  acts_as_taggable
  has_many :station_videos
  has_many :stations, :through => :station_videos
  
  MEDIA_TYPES = [[0, "inactive"],[0, "youtube_search"], [1, "vimeo_search"], [2, "youtube_user_added"], [4, "vimeo_user_added"]]
  YOUTUBE = "youtube"
  VIMEO = "vimeo"
  
  YOUTUBE_DEV_KEY =  "AI39si5-1s6CVSSGdBqlMnzN9v_OMBufAMEW-0H4Ke1UG5laQpDCWyWJU5WJlpVHPXSTHyBDHEoFsbBdLfwgHBs7Aic3tjHR0Q"
  VIMEO_AUTH = "0ded35edb12d54c74dbe3622352ceec3"
  VIMEO_SECRET = "d07ca9c1a42c7a7"
  
  
  
  
  
  def media_url
    if self.get_media_type == YOUTUBE
      "http://www.youtube.com/embed/#{self.media_id}"
    elsif self.get_media_type == VIMEO
      "http://player.vimeo.com/video/#{self.media_id}?title=0&amp;byline=0&amp;portrait=0&amp;color=ff00ff"
    end
  end
  
  
  def get_media_type
    if self.media_type == 0 || self.media_type == 2
      YOUTUBE
    elsif self.media_type == 1 || self.media_type == 4
      VIMEO
    else
      false
    end
  end
  
  
  #instance methods  needs refactoring
  def self.search_all query
    Video.youtube_search(query)
    Video.vimeo_search(query)
  end

  def self.youtube_search query
    client = YouTubeIt::Client.new(:dev_key =>YOUTUBE_DEV_KEY)
    youtubes = client.videos_by({ :query => query })
    
    youtubes.videos.each do |youtube|
      m = Video.find_or_create_from_youtube(query, youtube)
    end
  end
  
  def self.vimeo_search query
    video = Vimeo::Advanced::Video.new(VIMEO_AUTH, VIMEO_SECRET)
    vimeos = video.search(query)
    
    vimeos["videos"]['video'].each do |vimeo|
      m = Video.find_or_create_from_vimeo(query, vimeo)
    end
  end
  
  def self.find_or_create_from_youtube(query, obj)
    media = Video.where(:media_type => 0, :media_id => obj.unique_id).first
    if media.blank?
      media = Video.create_from_youtube(query, obj)
    else
      unless media.tag_list.include?(query)
        media.tag_list << query 
        media.save
      end
      media
    end
  end
  
  def self.find_or_create_from_vimeo(query, obj)
    media = Video.where(:media_type => 1, :media_id => obj['id']).first
    if media.blank?
      media = Video.create_from_vimeo(query, obj)
    else
      unless media.tag_list.include?(query)
        media.tag_list << query
        media.save
      end
      media
    end
  end
  
  def self.create_from_youtube(query,obj)
    media = Video.new
    media.title = obj.title
    media.media_type = 0
    media.media_id = obj.unique_id
    if obj.unique_id == 0 || obj.unique_id == 86
      puts 'coskun sabah'
    else
    end
      
    obj.keywords.each {|k| media.tag_list << k}
    media.tag_list << query
    media.save
    media
  end

  def self.create_from_vimeo(query,obj)
    media = Video.new
    media.title = obj['title']
    media.media_type = 1
    media.media_id = obj['id']
    media.tag_list = query
    media.save
    media
  end
  
end
