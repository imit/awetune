class StationVideo < ActiveRecord::Base
  attr_accessible :video_id, :station_id, :video
  
  belongs_to :video
  belongs_to :station

end
