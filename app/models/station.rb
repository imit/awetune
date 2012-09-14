class Station < ActiveRecord::Base
  attr_accessible :name, :description
  
  belongs_to :user
  has_many :station_videos,:dependent => :destroy
  
  
  def add_video video
    sv = self.station_videos.create(:video => video)
  end
  
end
