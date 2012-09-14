class CreateStationVideos < ActiveRecord::Migration
  def change
    create_table :station_videos do |t|
      t.references :video
      t.references :station

      t.timestamps
    end
    add_index :station_videos, :video_id
    add_index :station_videos, :station_id
  end
end
